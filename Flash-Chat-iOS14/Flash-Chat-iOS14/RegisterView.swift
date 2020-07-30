//
//  RegisterView.swift
//  Flash-Chat-iOS14
//
//  Created by Karmjit Singh on 30/7/20.
//

import SwiftUI
import Firebase

struct RegisterView: View {
    @State var emailId: String = ""
    @State var password: String = ""
    @State var registrationSuccessful: Bool = false
    
    var body: some View {
        ZStack {
            Background()
            VStack {
                
                
                VStack {
                    TextField("Email Id", text: $emailId)
                        .textFieldStyle(CustomTextFieldStyle())
                    SecureField("Password", text: $password)
                        .textFieldStyle(CustomTextFieldStyle())
                    Spacer()
                }
                .navigationTitle("Register")
                .padding()
                Spacer()
                VStack {
                    NavigationLink(
                        destination: ChatView(),
                        isActive: $registrationSuccessful
                    ){ EmptyView() }
                    Button("Register"){
                        Auth.auth().createUser(withEmail: emailId, password: password) { authResult, error in
                            if let e = error {
                                print(e.localizedDescription)
                            } else {
                                print(authResult ?? "")
                                registrationSuccessful = true
                            }
                        }
                    }.foregroundColor(.white)
                    .padding()
                    .buttonStyle(BorderedButton(backgroundColor: Color(UIColor.blue)))
                }
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(emailId: "", password: "")
    }
}

