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
            List {
                if let messages = model.messages {
                    ForEach(messages, id:\.id){ message in
                        Text(message.body)
                    }
                }
            }
            Spacer()
            
        }
        
        .navigationBarTitle("Chat")
        .navigationBarItems(trailing: logoutButton)
        .navigationBarBackButtonHidden(true)
        .toolbar(items: {
            ToolbarItem(placement: .bottomBar) {
                TextField("message", text: $message)
            }
        })
    }
}

extension ChatView {
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
