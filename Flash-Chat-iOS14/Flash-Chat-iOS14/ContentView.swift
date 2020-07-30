//
//  ContentView.swift
//  Flash-Chat-iOS14
//
//  Created by Karmjit Singh on 27/7/20.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @State private var selection: String? = nil
   
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(
                    destination: ChatView(),
                    tag: "ChatView",
                    selection: $selection){ EmptyView() }
                NavigationLink(
                    destination: LaunchView(),
                    tag: "LaunchView",
                    selection: $selection){ EmptyView() }
            }
        }
        .onAppear {
            if Auth.auth().currentUser != nil {
               selection = "ChatView"
            }
            else {
                selection = "LaunchView"
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
