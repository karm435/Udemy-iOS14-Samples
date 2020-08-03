//
//  ChatView.swift
//  Flash-Chat-iOS14
//
//  Created by Karmjit Singh on 30/7/20.
//

import SwiftUI
import Firebase
import Combine

struct ChatView: View {
    @State var successfullyLoggedOut = false
    
    @EnvironmentObject private var model: ChatModel
    @State private var message: String = ""
    @State private var cancellables: Set<AnyCancellable> = []
    
    var body: some View {
        let logoutButton = VStack {
            NavigationLink(
                destination: LaunchView(),
                isActive: $successfullyLoggedOut) { EmptyView()}
            Button("Logout") {
                logout()
            }
            .accessibility(label: Text("Logout"))
        }
        
        VStack {
            VStack{
                
                Text("Today")
                    .font(.subheadline)
                
                if !model.hasMessages {
                    Text("This is starting of the conversation.")
                        .font(.caption)
                }
            }
            
            List {
                if let messages = model.messages {
                    ForEach(messages, id:\.id){ message in
                        Text(message.body)
                    }
                }
            }
            
            Spacer()
            HStack {
                
                TextField("Message", text: $message)
                    .textFieldStyle(CustomTextFieldStyle(maxHeight: 10))
                    .padding(.trailing)
                Button(action: {
                    send(message: message)
                }, label: {
                    Image(systemName: "paperplane.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .trailing)
                })
            }
            .padding()
            
        }
        
        .navigationBarTitle("Chat")
        .navigationBarItems(trailing: logoutButton)
        .navigationBarBackButtonHidden(true)
    }
}

extension ChatView {
    private func send(message: String) {
        model.send(message: message)
            .assertNoFailure()
            .receive(on: RunLoop.main)
            .sink(receiveValue: {value in
                if value {
                    self.message = ""
                }
            })
            .store(in: &cancellables)
    }
    private func logout() {
        model.logout()
            .assertNoFailure()
            .receive(on: RunLoop.main)
            .assign(to: \.successfullyLoggedOut, on: self)
            .store(in: &cancellables)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
            .environmentObject(ChatModel())
    }
}
