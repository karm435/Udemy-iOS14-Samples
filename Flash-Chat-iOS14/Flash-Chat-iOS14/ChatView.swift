//
//  ChatView.swift
//  Flash-Chat-iOS14
//
//  Created by Karmjit Singh on 30/7/20.
//

import SwiftUI
import Firebase

struct ChatView: View {
    @State var successfullyLoggedOut = false
    var body: some View {
        let logoutButton = VStack {
            NavigationLink(
                destination: LaunchView(),
                isActive: $successfullyLoggedOut) { EmptyView()}
            Button("Logout") {
                logout()
            }
        }
        
        VStack {
            Text("Chat View")
        }
        .navigationBarTitle("Chat")
        .navigationBarItems(trailing: logoutButton)
        .navigationBarBackButtonHidden(true)
    }
}

extension ChatView {
    private func logout() {
        print("logout")
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("logout successful")
            successfullyLoggedOut = true
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
