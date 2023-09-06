import SwiftUI

struct StartView: View {
    @EnvironmentObject private var appState: AppState
    @State private var isAdding: Bool = false
    @State private var isRemoving: Bool = false
    @State private var inputModelUrl: String = ""
    @State private var showChatView: Bool = false // New state variable
    // Create an instance of HealthData, populated initially from your @AppStorage values


    @AppStorage("Age") public var Age: String = ""
    @AppStorage("Weight") public var Weight: String = ""
    @AppStorage("Height") public var Height: String = ""
    @AppStorage("Symptoms") public var Symptoms: String = ""
    @AppStorage("Allergies") public var Allergies: String = ""
    @AppStorage("Medications") public var Medications: String = ""
    @AppStorage("Temperature") public var Temperature: String = ""
    @AppStorage("Heart_Rate") public var Heart_Rate: String = ""
    @AppStorage("Respiratory Rate") public var Respiratory_Rate: String = ""
    @AppStorage("Oxygen Saturation") public var Oxygen_Saturation: String = ""
    @AppStorage("Waist Circumference") public var Waist_Circumference: String = ""
    @AppStorage("Hip Circumference") public var Hip_Circumference: String = ""
    @AppStorage("Diastolic Blood Pressure") public var Diastolic_Blood_Pressure: String = ""
    @AppStorage("Systolic Blood Pressure") public var Systolic_Blood_Pressure: String = ""
    @AppStorage("Albumin") public var Albumin: String = ""
    @AppStorage("ALT") public var ALT: String = ""
    @AppStorage("AST") public var AST: String = ""
    @AppStorage("BUN") public var BUN: String = ""
    @AppStorage("Calcium") public var Calcium: String = ""
    @AppStorage("Creatinine") public var Creatinine: String = ""
    @AppStorage("Glucose") public var Glucose: String = ""
    @AppStorage("HbA1c") public var HbA1c: String = ""
    @AppStorage("Potassium") public var Potassium: String = ""
    @AppStorage("Sodium") public var Sodium: String = ""
    @AppStorage("Triglycerides") public var Triglycerides: String = ""
    @AppStorage("LDL") public var LDL: String = ""
    @AppStorage("HDL") public var HDL: String = ""
    @AppStorage("eGFR") public var eGFR: String = ""
    

    
    var body: some View {
        NavigationView {
            
          
            ZStack {
                Color(.systemGray6)
                                   .edgesIgnoringSafeArea(.all)
                Text("Hello, World!")  // <-- This is the new line of code
                                    .font(.largeTitle)
                                    .foregroundColor(Color.red)
                                    .padding()
                // Setting background image
//                Image("background")
//                    .resizable()
//               //     .scaledToFill()
//                    .edgesIgnoringSafeArea(.all)
////
              
         
                // Replacing List with ScrollView and LazyVStack
           //    ScrollView {
                VStack {
                    (
                        Text("Welcome to the waiting room! Here you can optionally fill out your health record, which will give ") +
                        Text("Dr Dignity")
                            .foregroundColor(Color.black) +
                        Text(" more insight into you.")
                    )
                    .font(.largeTitle)
                    .foregroundColor(Color.teal)
                    .padding()
                    
                    
         
                

                    LazyVStack {
                        Section() {
                            
                            ForEach(appState.models) { modelState in
                                                            ModelView(isRemoving: $isRemoving)
                                                                .environmentObject(modelState)
                                                                .environmentObject(appState.chatState)
                        
                        
                        
                                                        }
                            
                            
//                            ModelView(isRemoving: $isRemoving).environmentObject(appState.models[1]).environmentObject(appState.chatState)
//                        }
//
//                            if appState.models.count > 1 {
//
//
//                                        ModelView(isRemoving: $isRemoving)
//                                            .environmentObject(appState.models[1])
//                                            .environmentObject(appState.chatState)
//
//
//                            }
                        }
                    }
                    // New button code
                    // NavigationLink
                                        NavigationLink(destination: ChatView()
                                                        .environmentObject(appState.chatState),
                                                       isActive: $showChatView) {
                                            EmptyView()
                                        }
                                        .hidden()
                                        .padding(20)
                                        

                                        Button("Chat with Dr. Dignity") {
                                            
                                            
                                       
                                            
                                            // Button action here
                                            print("Hello button tapped!")
                                            
                                            
                                                 var systemPrompt = "You are Doctor Dignity, the world's most advanced AI doctor, capable of accurately providing patients with high-quality medical advice. Here is your next patient's health data:\n"
                                           
                                                                       if !Age.isEmpty {
                                                                           systemPrompt += "Age:\(Age)\n"
                                                                       }
                                                                       if !Weight.isEmpty {
                                                                           systemPrompt += "Weight:\(Weight)\n"
                                                                       }
                                                                       if !Height.isEmpty {
                                                                           systemPrompt += "Height:\(Height)\n"
                                                                       }
                                                                       if !Symptoms.isEmpty {
                                                                           systemPrompt += "Symptoms:\(Symptoms)\n"
                                                                       }
                                                                       if !Allergies.isEmpty {
                                                                           systemPrompt += "Allergies:\(Allergies)\n"
                                                                       }
                                                                       if !Medications.isEmpty {
                                                                           systemPrompt += "Medications:\(Medications)\n"
                                                                       }
                                                                       if !Temperature.isEmpty {
                                                                           systemPrompt += "Temperature:\(Temperature)\n"
                                                                       }
                                                                       if !Heart_Rate.isEmpty {
                                                                           systemPrompt += "Heart_Rate:\(Heart_Rate)\n"
                                                                       }
                                                                       if !Respiratory_Rate.isEmpty {
                                                                           systemPrompt += "Respiratory_Rate:\(Respiratory_Rate)\n"
                                                                       }
                                                                       if !Oxygen_Saturation.isEmpty {
                                                                           systemPrompt += "Oxygen_Saturation:\(Oxygen_Saturation)\n"
                                                                       }
                                                                       if !Waist_Circumference.isEmpty {
                                                                           systemPrompt += "Waist_Circumference:\(Waist_Circumference)\n"
                                                                       }
                                                                       if !Hip_Circumference.isEmpty {
                                                                           systemPrompt += "Hip_Circumference:\(Hip_Circumference)\n"
                                                                       }
                                                                       if !Diastolic_Blood_Pressure.isEmpty {
                                                                           systemPrompt += "Diastolic_Blood_Pressure:\(Diastolic_Blood_Pressure)\n"
                                                                       }
                                                                       if !Systolic_Blood_Pressure.isEmpty {
                                                                           systemPrompt += "Systolic_Blood_Pressure:\(Systolic_Blood_Pressure)\n"
                                                                       }
                                                                       if !Albumin.isEmpty {
                                                                           systemPrompt += "Albumin:\(Albumin)\n"
                                                                       }
                                                                       if !ALT.isEmpty {
                                                                           systemPrompt += "ALT:\(ALT)\n"
                                                                       }
                                                                       if !AST.isEmpty {
                                                                           systemPrompt += "AST:\(AST)\n"
                                                                       }
                                                                       if !BUN.isEmpty {
                                                                           systemPrompt += "BUN:\(BUN)\n"
                                                                       }
                                                                       if !Calcium.isEmpty {
                                                                           systemPrompt += "Calcium:\(Calcium)\n"
                                                                       }
                                                                       if !Creatinine.isEmpty {
                                                                           systemPrompt += "Creatinine:\(Creatinine)\n"
                                                                       }
                                                                       if !Glucose.isEmpty {
                                                                           systemPrompt += "Glucose:\(Glucose)\n"
                                                                       }
                                                                       if !HbA1c.isEmpty {
                                                                           systemPrompt += "HbA1c:\(HbA1c)\n"
                                                                       }
                                                                       if !Potassium.isEmpty {
                                                                           systemPrompt += "Potassium:\(Potassium)\n"
                                                                       }
                                                                       if !Sodium.isEmpty {
                                                                           systemPrompt += "Sodium:\(Sodium)\n"
                                                                       }
                                                                       if !Triglycerides.isEmpty {
                                                                           systemPrompt += "Triglycerides:\(Triglycerides)\n"
                                                                       }
                                                                       if !LDL.isEmpty {
                                                                           systemPrompt += "LDL:\(LDL)\n"
                                                                       }
                                                                       if !HDL.isEmpty {
                                                                           systemPrompt += "HDL:\(HDL)\n"
                                                                       }
                                                                       if !eGFR.isEmpty {
                                                                           systemPrompt += "eGFR:\(eGFR)\n"
                                                                       }
                                           
                                                                  //     systemPrompt += "\nNow that you've seen these biomarkers, the patient would like to see you. Please respond exactly like a licensed medical doctor would. Do not make any assumptions about the patient initially, but use the patient's biomarker data you've been to guide your response. The patient asks the following question:\n"
                                           
                                                                       systemPrompt += "\nPlease remember this information to provide either an accurate assessment of their health or a comprehensive overall assessment of their health. They would now would like to speak with you. Please respond accordingly. The patient asks the following question:\n"
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            print("information " + systemPrompt)
                                            appState.chatState.getBioData(prompt: systemPrompt)
                                                                   appState.models[0].startChat(chatState: appState.chatState)
                                                                   showChatView = true
                                     
                                        }.padding()
                        .foregroundColor(.white)
                        .background(Color.teal)
                        .cornerRadius(10)
                                  
                }
//                }
//                .background(Color.clear) // Ensure the background is transparent to see the image
            }.onChange(of: Age) { newValue in
                appState.chatState.requestResetChat()
              
                    }
            .onChange(of: Weight) { newValue in
                appState.chatState.requestResetChat()
              
                    }
            .onChange(of: Height) { newValue in
                appState.chatState.requestResetChat()
              
                    }
            .onChange(of: Symptoms) { newValue in
                appState.chatState.requestResetChat()
              
                    }
            .onChange(of: Allergies) { newValue in
                appState.chatState.requestResetChat()
              
                    }
            .onChange(of: Medications) { newValue in
                appState.chatState.requestResetChat()
              
                    }
            .onChange(of: Temperature) { newValue in
                appState.chatState.requestResetChat()
              
                    }
            .onChange(of: Heart_Rate) { newValue in
                appState.chatState.requestResetChat()
              
                    }
            .onChange(of: Respiratory_Rate) { newValue in
                appState.chatState.requestResetChat()
              
                    }
            .onChange(of: Oxygen_Saturation) { newValue in
                appState.chatState.requestResetChat()
              
                    }
            .onChange(of: Waist_Circumference) { newValue in
                appState.chatState.requestResetChat()
              
                    }
            .onChange(of: Hip_Circumference) { newValue in
                appState.chatState.requestResetChat()
              
                    }
            .onChange(of: Diastolic_Blood_Pressure) { newValue in
                appState.chatState.requestResetChat()
              
                    }
            .onChange(of: Systolic_Blood_Pressure) { newValue in
                appState.chatState.requestResetChat()
              
                    }
            .onChange(of: Albumin) { newValue in
                appState.chatState.requestResetChat()
              
                    }
            .onChange(of: ALT) { newValue in
                appState.chatState.requestResetChat()
              
                    }
            .onChange(of: AST) { newValue in
                appState.chatState.requestResetChat()
              
                    }
            .onChange(of: BUN) { newValue in
                appState.chatState.requestResetChat()
              
                    }
            .onChange(of: Calcium) { newValue in
                appState.chatState.requestResetChat()
              
                    }
            .onChange(of: Creatinine) { newValue in
                appState.chatState.requestResetChat()
              
                    }
            .onChange(of: Glucose) { newValue in
                appState.chatState.requestResetChat()
              
                    }
            .onChange(of: HbA1c) { newValue in
                appState.chatState.requestResetChat()
              
                    }
            .onChange(of: Potassium) { newValue in
                appState.chatState.requestResetChat()
              
                    }
            .onChange(of: Sodium) { newValue in
                appState.chatState.requestResetChat()
              
                    }
            .onChange(of: Triglycerides) { newValue in
                appState.chatState.requestResetChat()
              
                    }
            .onChange(of: LDL) { newValue in
                appState.chatState.requestResetChat()
              
                    }
            .onChange(of: HDL) { newValue in
                appState.chatState.requestResetChat()
              
                    }
            .onChange(of: eGFR) { newValue in
                appState.chatState.requestResetChat()
              
                    }
            
            
            
            .navigationTitle("Back")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Dr Dignity")
                        .font(.headline)
                        .foregroundColor(.teal)
                }
            }
            .alert("Error", isPresented: $appState.alertDisplayed) {
                Button("OK") { }
            } message: {
                Text(appState.alertMessage)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(Color.teal) // Optional: Setting the accent color to teal
    }
}

struct HealthData: Equatable {
    var age: String
    var weight: String
    var height: String
    // ... (all your other variables)
}
