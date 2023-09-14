import SwiftUI
import UIKit

struct CustomTextField: UIViewRepresentable {
    @Binding var text: String

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.returnKeyType = .done
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: CustomTextField
        
        init(_ parent: CustomTextField) {
            self.parent = parent
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }
    }
}

struct ContentView: View {
    @State private var text: String = ""
    
    var body: some View {
        CustomTextField(text: $text)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
            .padding()
    }
}



struct ModelView: View {

    @Environment(\.colorScheme) var colorScheme

    @EnvironmentObject private var modelState: ModelState
    @EnvironmentObject private var chatState: ChatState
    @Binding var isRemoving: Bool
    
    @State private var isShowingDeletionConfirmation: Bool = false
    
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
    
    @State private var isCoreExpanded: Bool = false
    @State private var isHealthExpanded: Bool = false
    @State private var isVitalsExpanded: Bool = false
    @State private var isLabTestResultsExpanded: Bool = false

    // State to hold text field values
    @State private var textFields: [String] {
        didSet {
            // Save to UserDefaults whenever the value changes
            UserDefaults.standard.set(textFields, forKey: "textFields")
        }
    }
    
    init(isRemoving: Binding<Bool>) {
        _isRemoving = isRemoving

        // Initialize from UserDefaults
        if let savedTextFields = UserDefaults.standard.array(forKey: "textFields") as? [String] {
            _textFields = State(initialValue: savedTextFields)
        } else {
            _textFields = State(initialValue: Array(repeating: "", count: 5))
        }
    }

    var body: some View {
        NavigationView {
            Form {
                DisclosureGroup("Core", isExpanded: $isCoreExpanded) {
                    HStack {
                        Text("Age:")
                            .frame(width: 80, alignment: .leading)
                        CustomTextField(text: $Age)
                            .background(colorScheme == .dark ? Color.clear : Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .padding()
                    }
                    HStack {
                        Text("Weight:")
                            .frame(width: 80, alignment: .leading)
                        CustomTextField(text: $Weight)
                            .background(colorScheme == .dark ? Color.clear : Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                    .padding()
                    }
                    HStack {
                        Text("Height:")
                            .frame(width: 80, alignment: .leading)
                        CustomTextField(text: $Height)
                            .background(colorScheme == .dark ? Color.clear : Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                    .padding()
                    }
                }
                .padding([.leading, .trailing], 8)
                
                
                
                DisclosureGroup("Health Information", isExpanded: $isHealthExpanded) {
                    HStack {
                        Text("Symptoms:")
                            .frame(width: 100, alignment: .leading)
                        CustomTextField(text: $Symptoms)
                                    .background(colorScheme == .dark ? Color.clear : Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                    .padding()
                    }
                    HStack {
                        Text("Allergies:")
                            .frame(width: 100, alignment: .leading)
                        CustomTextField(text: $Allergies)
                            .background(colorScheme == .dark ? Color.clear : Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                    .padding()
                    }
                    HStack {
                        Text("Medications:")
                            .frame(width: 100, alignment: .leading)
                        CustomTextField(text: $Medications)
                                    .background(colorScheme == .dark ? Color.clear : Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                    .padding()
                    }
                }
                .padding([.leading, .trailing], 8)
                
                
                DisclosureGroup("Vitals", isExpanded: $isVitalsExpanded) {
                    HStack {
                        Text("Temp.:")
                            .frame(width: 100, alignment: .leading)
                        CustomTextField(text: $Temperature)
                            .background(colorScheme == .dark ? Color.clear : Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                    .padding()
                    }
                    HStack {
                        Text("Heart Rate:")
                            .frame(width: 100, alignment: .leading)
                        CustomTextField(text: $Heart_Rate)
                            .background(colorScheme == .dark ? Color.clear : Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                    .padding()
                    }
                    HStack {
                        Text("Respiratory Rate:")
                            .frame(width: 100, alignment: .leading)
                        CustomTextField(text: $Respiratory_Rate)
                            .background(colorScheme == .dark ? Color.clear : Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                    .padding()
                    }
                    HStack {
                        Text("Oxygen Saturation:")
                            .frame(width: 100, alignment: .leading)
                        CustomTextField(text: $Oxygen_Saturation)
                            .background(colorScheme == .dark ? Color.clear : Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                    .padding()
                    }
                    HStack {
                        Text("Waist Circum.:")
                            .frame(width: 100, alignment: .leading)
                        CustomTextField(text: $Waist_Circumference)
                            .background(colorScheme == .dark ? Color.clear : Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                    .padding()
                    }
                    HStack {
                        Text("Hip Circum.:")
                            .frame(width: 100, alignment: .leading)
                        CustomTextField(text: $Hip_Circumference)
                            .background(colorScheme == .dark ? Color.clear : Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                    .padding()
                    }
                    HStack {
                        Text("Diastolic Blood Pressure:")
                            .frame(width: 100, alignment: .leading)
                        CustomTextField(text: $Diastolic_Blood_Pressure)
                            .background(colorScheme == .dark ? Color.clear : Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                    .padding()
                    }
                    HStack {
                        Text("Systolic Blood Pressure:")
                            .frame(width: 100, alignment: .leading)
                        CustomTextField(text: $Systolic_Blood_Pressure)
                            .background(colorScheme == .dark ? Color.clear : Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                    .padding()
                    }
                }
                .padding([.leading, .trailing], 8)
                
                
                
                DisclosureGroup("Lab Test Results", isExpanded: $isLabTestResultsExpanded) {
                    HStack {
                        Text("Albumin:")
                            .frame(width: 100, alignment: .leading)
                        CustomTextField(text: $Albumin)
                            .background(colorScheme == .dark ? Color.clear : Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                    .padding()
                    }
                    HStack {
                        Text("ALT:")
                            .frame(width: 100, alignment: .leading)
                        CustomTextField(text: $ALT)
                            .background(colorScheme == .dark ? Color.clear : Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                    .padding()
                    }
                    HStack {
                        Text("AST:")
                            .frame(width: 100, alignment: .leading)
                        CustomTextField(text: $AST)
                            .background(colorScheme == .dark ? Color.clear : Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                    .padding()
                    }
                    HStack {
                        Text("BUN:")
                            .frame(width: 100, alignment: .leading)
                        CustomTextField(text: $BUN)
                            .background(colorScheme == .dark ? Color.clear : Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                    .padding()
                    }
                    HStack {
                        Text("Calcium:")
                            .frame(width: 100, alignment: .leading)
                        CustomTextField(text: $Calcium)
                            .background(colorScheme == .dark ? Color.clear : Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                    .padding()
                    }
                    HStack {
                        Text("Creatinine:")
                            .frame(width: 100, alignment: .leading)
                        CustomTextField(text: $Creatinine)
                            .background(colorScheme == .dark ? Color.clear : Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                    .padding()
                    }
                    HStack {
                        Text("Glucose:")
                            .frame(width: 100, alignment: .leading)
                        CustomTextField(text: $Glucose)
                            .background(colorScheme == .dark ? Color.clear : Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                    .padding()
                    }
                    HStack {
                        Text("HbA1c:")
                            .frame(width: 100, alignment: .leading)
                        CustomTextField(text: $HbA1c)
                            .background(colorScheme == .dark ? Color.clear : Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                    .padding()
                    }
                    HStack {
                        Text("Potassium:")
                            .frame(width: 100, alignment: .leading)
                        CustomTextField(text: $Potassium)
                            .background(colorScheme == .dark ? Color.clear : Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                    .padding()
                    }
                    HStack {
                        Text("Sodium:")
                            .frame(width: 100, alignment: .leading)
                        CustomTextField(text: $Sodium)
                            .background(colorScheme == .dark ? Color.clear : Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                    .padding()
                    }
                    
                    
                }
                .padding([.leading, .trailing], 8)
                
                
            }

           
            
            
        }
    }


}

