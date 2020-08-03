//
//  Flash_Chat_iOS14App.swift
//  Flash-Chat-iOS14
//
//  Created by Karmjit Singh on 27/7/20.
//

import SwiftUI
import Firebase
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        _ = Firestore.firestore()
        return true
    }
}


@main
struct Flash_Chat_iOS14App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var model = ChatModel()
   
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}
