//
//  FireStoreModels.swift
//  Flash-Chat-iOS14
//
//  Created by Karmjit Singh on 3/8/20.
//

import Foundation
import Combine
import Firebase
import os

class ChatModel: ObservableObject {
    @Published private(set) var account: Account?
    @Published private(set) var messages: [Message]?
    private var logger = Logger(subsystem: "com.karmjitsingh.Flash-Chat-iOS14", category: "ChatModel")
    private var cancellables: Set<AnyCancellable> = []
    
    var hasAccount: Bool {
        #if targetEnvironment(simulator)
        account = Account(emailId: "test@email.com")
        messages = [
            Message(id: UUID(), body: "Message 1", senddate: Date.init()),
            Message(id: UUID(), body: "Message 2", senddate: Date.init()),
            Message(id: UUID(), body: "Message 3", senddate: Date.init())
        ]
        return true
        #else
        return account != nil
        #endif
    }
    
    var hasMessages: Bool {
        if let messages = messages {
            return messages.count > 0
        }
        return false
    }
    
    var db : Firestore {
        Firestore.firestore()
    }
    
    init() {
        if account == nil, let currentUser = Auth.auth().currentUser?.email {
            account = Account(emailId: currentUser)
        }
    }
}

extension ChatModel {
    func createUser(emailId: String, password: String) -> AnyPublisher<Bool, Error> {
        Future<Bool, Error> { promise in
            Auth.auth().createUser(withEmail: emailId, password: password) { authResult, error in
                if let e = error {
                    self.logger.critical("\(e.localizedDescription)")
                    return promise(.failure(e))
                } else {
                    print(authResult ?? "")
                    self.createAccount()
                    return promise(.success(true))
                }
            }
        }
        .eraseToAnyPublisher()
        
    }
    
    func login(emailId: String, password: String) -> AnyPublisher<Bool, Error>{
        Future<Bool, Error> { promise in
            Auth.auth().signIn(withEmail: emailId, password: password) { authResult, error in
                if let e = error {
                    self.logger.critical("\(e.localizedDescription)")
                    return promise(.failure(e))
                } else {
                    print(authResult ?? "")
                    self.createAccount()
                    return promise(.success(true))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func logout() -> AnyPublisher<Bool, Error>{
        Future<Bool, Error> { promise in
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                self.logger.debug("logout successful")
                return promise(.success(true))
            } catch let signOutError as NSError {
                self.logger.critical("Error signing out: \(signOutError.localizedDescription)")
                return promise(.failure(signOutError))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func send(message: String) -> AnyPublisher<Bool, Error>{
        Future<Bool, Error> { promise in
            self.db.collection(Constants.FStore.dbCollectionName)
                .addDocument(data: ["message": message, "sender": self.account!.emailId]) { err in
                    if let error = err {
                        self.logger.critical("\(error.localizedDescription)")
                        return promise(.failure(error))
                    }
                    else {
                        return promise(.success(true))
                    }
            }
        }
        .eraseToAnyPublisher()
    }
    
    private func createAccount(){
        if account == nil, let currentUser = Auth.auth().currentUser?.email {
            account = Account(emailId: currentUser)
        }
    }
}

struct AuthError: Error {
    
}
