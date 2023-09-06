//
//  ChatView.swift
//  MLCChat
//

import SwiftUI
import GameController

struct ChatView: View {
    @EnvironmentObject private var chatState: ChatState

    @State private var inputMessage: String = ""
    @FocusState private var inputIsFocused: Bool
    @Environment(\.dismiss) private var dismiss
    @Namespace private var messagesBottomID

    // vision-related properties
    @State private var showActionSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var imageConfirmed: Bool = false
    @State private var imageSourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var image: UIImage?
    private let mediumImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    @State private var showFAQ: Bool = false

    
    var body: some View {
        VStack {
            //  modelInfoView.navigationBarBackButtonHidden(true)  // Sets the background color to green
            messagesView.foregroundColor(Color.teal)  // Sets the background color to green
            uploadImageView
            messageInputView.foregroundColor(Color.teal)
        }
        .alert(isPresented: $showFAQ) {
            Alert(title: Text("Information"),
                  message: Text("Dr Dignity is a private local large language model. It is based off the 3 billion parameter redpajama language model and prompted to be a doctor. do not take any of this advice seriously yet. we are working on this fulltime as an open source, open data, and open weights project to ensure it's reliability in the coming months and years."),
                  dismissButton: .default(Text("Thanks!")))
        }
        .navigationBarTitle("Dr Dignity", displayMode: .inline)
      //  .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button(action: {
                                  // Add Help action here
                        self.showFAQ.toggle()

                              }) {
                                  HStack {
                                      Image(systemName: "info")
                                      Text("Info")
                                  }
                              }
                    Button(action: {
                                    // Add Clear Conversation action here
                        chatState.requestResetChat()
                        
                                })
 {
                                    HStack {
                                        Image(systemName: "trash").foregroundColor(Color.red)
                                        Text("Clear Conversation").foregroundColor(Color.red)
                                    }
                                }.accentColor(Color.red)
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .foregroundColor(Color.teal)
                        .padding()
                        .disabled(!chatState.isResettable)
                }
            }
        }

    }
}

private extension ChatView {
    var modelInfoView: some View {
        Text(chatState.infoText)
            .font(.system(size: 12))
            .multilineTextAlignment(.center)
            .opacity(0.5)
            .listRowSeparator(.hidden)
    }

    var messagesView: some View {
        ScrollViewReader { scrollViewProxy in
            ScrollView {
                VStack {
                    let messageCount = chatState.messages.count
                    let hasSystemMessage = messageCount > 0 && chatState.messages[0].role == MessageRole.bot
                    let startIndex = hasSystemMessage ? 1 : 0

                    // display the system message
                    if hasSystemMessage {
                        MessageView(role: chatState.messages[0].role, message: chatState.messages[0].message)
                    }

                    // display image
                    if let image, imageConfirmed {
                        ImageView(image: image)
                    }

                    // display conversations
                    ForEach(chatState.messages[startIndex...], id: \.id) { message in
                        MessageView(role: message.role, message: message.message)
                    }
                    HStack { EmptyView() }
                        .id(messagesBottomID)
                }
            }
            .onChange(of: chatState.messages) { _ in
                withAnimation {
                    scrollViewProxy.scrollTo(messagesBottomID, anchor: .bottom)
                }
            }
        }
    }

    @ViewBuilder
    var uploadImageView: some View {
        if chatState.useVision && !imageConfirmed {
            if image == nil {
                Button("Upload picture to chat") {
                    showActionSheet = true
                }
                .actionSheet(isPresented: $showActionSheet) {
                    ActionSheet(title: Text("Choose from"), buttons: [
                        .default(Text("Photo Library")) {
                            showImagePicker = true
                            imageSourceType = .photoLibrary
                        },
                        .default(Text("Camera")) {
                            showImagePicker = true
                            imageSourceType = .camera
                        },
                        .cancel()
                    ])
                }
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(image: $image,
                                showImagePicker: $showImagePicker,
                                imageSourceType: imageSourceType)
                }
                .disabled(!chatState.isUploadable)
            } else {
                VStack {
                    if let image {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 300, height: 300)

                        HStack {
                            Button("Undo") {
                                self.image = nil
                            }
                            .padding()

                            Button("Submit") {
                                imageConfirmed = true
                                chatState.requestProcessImage(image: image)
                            }
                            .padding()
                        }
                    }
                }
            }
        }
    }

    var messageInputView: some View {
        VStack {
            HStack {
                TextField("Ask a health or bioscience question:", text: $inputMessage, axis: .vertical)
                    .tint(Color.teal)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minHeight: CGFloat(30))
                    .focused($inputIsFocused)
                    .onAppear {
                        
                       // DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                          // chatState.requestGenerate(prompt: "You are a Doctor,")
                     //   }
                        //                        chatState.requestGenerate(prompt: "hello")

                    }
                    .onSubmit {
                        let isKeyboardConnected = GCKeyboard.coalesced != nil
                        if isKeyboardConnected {
                            send()
                        }
                    }
                Button(action: {
                    mediumImpactFeedbackGenerator.prepare()
                    send()
                    mediumImpactFeedbackGenerator.impactOccurred()

                }) {
                    
                    if chatState.isTyping {
                                        Image(systemName: "stop.circle") // Show Apple logo when typing
                                    } else {
                                        Image(systemName: "paperplane") // Show paperplane otherwise
                                    }
                }
                .bold()
                .disabled(!(chatState.isChattable && inputMessage != ""))
            }
            .frame(minHeight: CGFloat(20))
            Text("Dr Dignity may produce inaccurate information.").font(.system(size: 12)).foregroundColor(.gray)  // Sets the text color to grey
                .opacity(0.5) // Your title text here
        }
        .padding()
    }


    func send() {
        inputIsFocused = false
        chatState.requestGenerate(prompt: inputMessage)
        inputMessage = ""
    }
}

