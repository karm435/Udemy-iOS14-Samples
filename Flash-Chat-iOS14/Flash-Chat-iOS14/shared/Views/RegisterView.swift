//
//  RegisterView.swift
//  Flash-Chat-iOS14
//
//  Created by Karmjit Singh on 30/7/20.
//

import SwiftUI
import Firebase
import Combine

struct RegisterView: View {
    @State var emailId: String = ""
    @State var password: String = ""
    @State var registrationSuccessful: Bool = false
    @EnvironmentObject private var model: ChatModel
    @State private var cancellables: Set<AnyCancellable> = []
    
    var body: some View {
        ZStack {
            Background()
            VStack {
                
                
                VStack {
                    TextField("Email Id", text: $emailId)
                        .textFieldStyle(CustomTextFieldStyle())
                        .accessibility(label: Text("Email Id"))
                    SecureField("Password", text: $password)
                        .textFieldStyle(CustomTextFieldStyle())
                        .accessibility(label: Text("Password"))
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
                        model.createUser(emailId: emailId, password: password)
                            .assertNoFailure()
                            .receive(on: RunLoop.main)
                            .assign(to: \.registrationSuccessful, on: self)
                            .store(in: &cancellables)
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

