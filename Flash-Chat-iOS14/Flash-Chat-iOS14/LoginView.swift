//
//  LoginView.swift
//  Flash-Chat-iOS14
//
//  Created by Karmjit Singh on 30/7/20.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State var emailId: String = ""
    @State var password: String = ""
    @State var loginSuccessFull = false
    
    var body: some View {
        ZStack {
            Background()
            VStack{
                VStack {
                    TextField("Email Id", text: $emailId)
                        .textFieldStyle(CustomTextFieldStyle())
                    SecureField("Password", text: $password)
                        .textFieldStyle(CustomTextFieldStyle())
                    Spacer()
                }
                .navigationTitle("Login")
                .padding()
                Spacer()
                VStack {
                    NavigationLink(
                        destination: ChatView(),
                        isActive: $loginSuccessFull
                    ){ EmptyView()}
                    Button("Login"){
                        Auth.auth().signIn(withEmail: emailId, password: password) { authResult, error in
                            if let e = error {
                                print(e.localizedDescription)
                            } else {
                                print(authResult ?? "")
                                loginSuccessFull = true
                            }
                            // ...
                        }
                    }.foregroundColor(.white)
                    .padding()
                    .buttonStyle(BorderedButton(backgroundColor: Color(UIColor.blue)))
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
