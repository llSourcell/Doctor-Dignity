//
//  ChatState.swift
//  LLMChat
//

import Foundation
import MLCSwift

enum MessageRole {
    case user
    case bot
}

extension MessageRole {
    var isUser: Bool { self == .user }
}

struct MessageData: Hashable {
    let id = UUID()
    var role: MessageRole
    var message: String
}

final class ChatState: ObservableObject {
    fileprivate enum ModelChatState {
        case generating
        case resetting
        case reloading
        case terminating
        case ready
        case failed
        case pendingImageUpload
        case processingImage
    }

    @Published var messages = [MessageData]()
    @Published var infoText = ""
    @Published var displayName = ""
    @Published var useVision = false
    @Published var isTyping = false
    @Published var public_prompt = ""
    @Published var isFirstPrompt = true

    
    private let modelChatStateLock = NSLock()
    private var modelChatState: ModelChatState = .ready

    private let threadWorker = ThreadWorker()
    private let chatModule = ChatModule()
    private var modelLib = ""
    private var modelPath = ""
    var localID = ""

    
    init() {
        threadWorker.qualityOfService = QualityOfService.userInteractive
        threadWorker.start()
        isFirstPrompt = true
    }
    
    var isInterruptible: Bool {
        return getModelChatState() == .ready
        || getModelChatState() == .generating
        || getModelChatState() == .failed
        || getModelChatState() == .pendingImageUpload
    }

    var isChattable: Bool {
        return getModelChatState() == .ready
    }

    var isUploadable: Bool {
        return getModelChatState() == .pendingImageUpload
    }

    var isResettable: Bool {
        return getModelChatState() == .ready
        || getModelChatState() == .generating
    }
    
    func requestResetChat() {
        guard isResettable else {
            return
        }
        
//        assert(isResettable)
        interruptChat(prologue: {
            switchToResetting()
        }, epilogue: { [weak self] in
            self?.mainResetChat()
        })
    }
    
    func requestTerminateChat(callback: @escaping () -> Void) {
        assert(isInterruptible)
        interruptChat(prologue: {
            switchToTerminating()
        }, epilogue: { [weak self] in
            self?.mainTerminateChat(callback: callback)
        })
    }
    
    func requestReloadChat(localID: String, modelLib: String, modelPath: String, estimatedVRAMReq: Int, displayName: String) {
        if (isCurrentModel(localID: localID)) {
            return
        }
        assert(isInterruptible)
        interruptChat(prologue: {
            switchToReloading()
        }, epilogue: { [weak self] in
            self?.mainReloadChat(localID: localID,
                                 modelLib: modelLib,
                                 modelPath: modelPath,
                                 estimatedVRAMReq: estimatedVRAMReq,
                                 displayName: displayName)
        })
    }
    
    
    func getBioData(prompt: String)  {
        public_prompt = prompt
    }

    func requestGenerate(prompt: String) {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
        
        assert(isChattable)
        switchToGenerating()
        appendMessage(role: .user, message: prompt)
        appendMessage(role: .bot, message: "")
        threadWorker.push {[weak self] in
            guard let self else { return }
            print("hello world")
            print("Yoyo" + public_prompt)
            let name = "john"
            
//
//            let systemPrompt = """
//            You are a licensed medical doctor and are advising a patient. This is their electronic medical record:
//              Age: \(Age)
//              Weight: \(Weight)
//              Height:
//              Symptoms:
//              Allergies:
//              Medications:
//              Temperature:
//              Heart_Rate:
//              Respiratory_Rate:
//              Oxygen_Saturation:
//              Waist_Circumference:
//              Hip_Circumference:
//              Diastolic_Blood_Pressure:
//              Systolic_Blood_Pressure:
//              Albumin:
//              ALT:
//              AST:
//              BUN:
//              Calcium:
//              Creatinine:
//              Glucose:
//              HbA1c:
//              Potassium:
//              Sodium:
//              Triglycerides:
//              LDL:
//              HDL:
//              eGFR:
//            They say the following to you:
//            """
            
            
           if isFirstPrompt  {
                chatModule.prefill(public_prompt + prompt)
               isFirstPrompt = false
           }
            else {
               chatModule.prefill(prompt)
          }
//            isTyping = true
//            if isTyping {
//               // TypingView()
//            }
            while !chatModule.stopped() {
                isTyping = true
                chatModule.decode()
                feedbackGenerator.impactOccurred()
                if let newText = chatModule.getMessage() {
                    DispatchQueue.main.async {
                        self.updateMessage(role: .bot, message: newText)
                    }
                }

                if getModelChatState() != .generating {
                    break
                }
            }
            isTyping = false
            if getModelChatState() == .generating {
                if let runtimeStats = chatModule.runtimeStatsText(useVision) {
                    DispatchQueue.main.async {
                        let regexPattern = "decode: (\\d+\\.?\\d*) tok/s"
                        do {
                                let regex = try NSRegularExpression(pattern: regexPattern, options: [])
                                if let match = regex.firstMatch(in: runtimeStats, options: [], range: NSRange(location: 0, length: runtimeStats.utf16.count)) {
                                    if let decodeRange = Range(match.range(at: 1), in: runtimeStats) {
                                        if let decodeSpeedTokPerS = Double(runtimeStats[decodeRange]) {
                                            let timePerTokenMS = 1000 / decodeSpeedTokPerS
                                            var endResult = "Decoding Speed: \(String(format: "%.2f", timePerTokenMS)) ms per token"
                                            self.infoText = endResult
                                            self.switchToReady()
                                        }
                                    }
                                }
                            } catch {
                            }

                     //   self.infoText = runtimeStats
                     //   self.switchToReady()
                    }
                }
            }
        }
    }

    func requestProcessImage(image: UIImage) {
        assert(getModelChatState() == .pendingImageUpload)
        switchToProcessingImage()
        threadWorker.push {[weak self] in
            guard let self else { return }
            assert(messages.count > 0)
            DispatchQueue.main.async {
                self.updateMessage(role: .bot, message: "[System] Processing image")
            }
            // step 1. resize image
            let new_image = resizeImage(image: image, width: 112, height: 112)
            // step 2. prefill image by chatModule.prefillImage()
            chatModule.prefillImage(new_image, prevPlaceholder: "<Img>", postPlaceholder: "</Img> ")
            DispatchQueue.main.async {
                self.updateMessage(role: .bot, message: "[System] Ready to chat")
                self.switchToReady()
            }
        }
    }

    func isCurrentModel(localID: String) -> Bool {
        return self.localID == localID
    }
}

private extension ChatState {
    func getModelChatState() -> ModelChatState {
        modelChatStateLock.lock()
        defer { modelChatStateLock.unlock() }
        return modelChatState
    }

    func setModelChatState(_ newModelChatState: ModelChatState) {
        modelChatStateLock.lock()
        modelChatState = newModelChatState
        modelChatStateLock.unlock()
    }

    func appendMessage(role: MessageRole, message: String) {
        messages.append(MessageData(role: role, message: message))
    }

    func updateMessage(role: MessageRole, message: String) {
        
        if messages.isEmpty {
                // Handle empty array; possibly append a new message if that's the correct behavior
                messages.append(MessageData(role: role, message: message))
            } else {
                // Update the last message
                messages[messages.count - 1] = MessageData(role: role, message: message)
            }
        
    }

    func clearHistory() {
        messages.removeAll()
        infoText = ""
        isFirstPrompt = true
    }

    func switchToResetting() {
        setModelChatState(.resetting)
    }

    func switchToGenerating() {
        setModelChatState(.generating)
    }

    func switchToReloading() {
        setModelChatState(.reloading)
    }

    func switchToReady() {
        setModelChatState(.ready)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {  // Added delay
//            self.chatModule.prefill("hello")
//  XC/
//        }
    }

    func switchToTerminating() {
        setModelChatState(.terminating)
    }

    func switchToFailed() {
        setModelChatState(.failed)
    }

    func switchToPendingImageUpload() {
        setModelChatState(.pendingImageUpload)
    }

    func switchToProcessingImage() {
        setModelChatState(.processingImage)
    }

    func interruptChat(prologue: () -> Void, epilogue: @escaping () -> Void) {
        assert(isInterruptible)
        if getModelChatState() == .ready
            || getModelChatState() == .failed
            || getModelChatState() == .pendingImageUpload {
            prologue()
            epilogue()
        } else if getModelChatState() == .generating {
            prologue()
            threadWorker.push {
                DispatchQueue.main.async {
                    epilogue()
                }
            }
        } else {
            assert(false)
        }
    }

    func mainResetChat() {
        threadWorker.push {[weak self] in
            guard let self else { return }

            if isResettable {
                chatModule.resetChat()
            } 
            if useVision {
                chatModule.resetImageModule()
            }
            DispatchQueue.main.async {
                self.clearHistory()
                if self.useVision {
                    self.appendMessage(role: .bot, message: "[System] Upload an image to chat")
                    self.switchToPendingImageUpload()
                } else {
                    self.updateMessage(role: .bot, message: "Hi! I'm Dr Dignity, your private health assistant. How can I assist you with your health and wellness journey today?")
                    self.switchToReady()
                }
            }
        }
    }

    func mainTerminateChat(callback: @escaping () -> Void) {
        threadWorker.push {[weak self] in
            guard let self else { return }
            if useVision {
                chatModule.unloadImageModule()
            }
            chatModule.unload()
            DispatchQueue.main.async {
                self.clearHistory()
                self.localID = ""
                self.modelLib = ""
                self.modelPath = ""
                self.displayName = ""
                self.useVision = false
                self.switchToReady()
                callback()
            }
        }
    }

    func mainReloadChat(localID: String, modelLib: String, modelPath: String, estimatedVRAMReq: Int, displayName: String) {
        clearHistory()
        let prevUseVision = useVision
        self.localID = localID
        self.modelLib = modelLib
        self.modelPath = modelPath
        self.displayName = displayName
        self.useVision = displayName.hasPrefix("minigpt")
        threadWorker.push {[weak self] in
            guard let self else { return }
            DispatchQueue.main.async {
                self.appendMessage(role: .bot, message: "Loading...")
            }
            if prevUseVision {
                chatModule.unloadImageModule()
            }
            chatModule.unload()
            let vRAM = os_proc_available_memory()
            if (vRAM < estimatedVRAMReq) {
                let requiredMemory = String (
                    format: "%.1fMB", Double(estimatedVRAMReq) / Double(1 << 20)
                )
                let errorMessage = (
                    "Sorry, the system cannot provide \(requiredMemory) VRAM as requested to the app, " +
                    "so we cannot initialize this model on this device."
                )
                DispatchQueue.main.sync {
                    self.messages.append(MessageData(role: MessageRole.bot, message: errorMessage))
                    self.switchToFailed()
                }
                return
            }

            if useVision {
                // load vicuna model
                let dir = (modelPath as NSString).deletingLastPathComponent
                let vicunaModelLib = "vicuna-7b-v1.3-q3f16_0"
                let vicunaModelPath = dir + "/" + vicunaModelLib
                let appConfigJSONData = try? JSONSerialization.data(withJSONObject: ["conv_template": "minigpt"], options: [])
                let appConfigJSON = String(data: appConfigJSONData!, encoding: .utf8)
                chatModule.reload(vicunaModelLib, modelPath: vicunaModelPath, appConfigJson: appConfigJSON)
                // load image model
                chatModule.reloadImageModule(modelLib, modelPath: modelPath)
            } else {
                chatModule.reload(modelLib, modelPath: modelPath, appConfigJson: "")
            }

            DispatchQueue.main.async {
                if self.useVision {
                    self.updateMessage(role: .bot, message: "[System] Upload an image to chat")
                    self.switchToPendingImageUpload()
                } else {
                    
                    self.updateMessage(role: .bot, message: "Hi! I'm Dr Dignity, your private health assistant. How can I assist you with your health and wellness journey today?")
                    self.switchToReady()
                }
            }
        }
    }
}

