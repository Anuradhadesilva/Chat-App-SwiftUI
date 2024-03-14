//
//  ChatViewModel.swift
//  Chat-App-SwiftUI
//
//  Created by Anuradha Desilva on 11/03/2024.
//

import Foundation
import Combine
class ChatViewModel:ObservableObject{
    @Published var messages = [Message]()
    var subcribers: Set<AnyCancellable> = []
    @Published var mockData = [
        Message(userUid: "123", text: "HI, How are you ?", photoURL: "", ceratedAt: Date()),
        Message(userUid: "123", text: "Where are you from?", photoURL: "", ceratedAt: Date()),
        Message(userUid: "123", text: "I am from Katubedda", photoURL: "", ceratedAt: Date()),
        Message(userUid: "123", text: "HI, How are you", photoURL: "", ceratedAt: Date()),
        
    ]
    
    init() {
        DatabaseManager.shared.fetchMessages{ [weak self] result in
            switch result {
            case .success(let msgs):
                self?.messages = msgs
            case.failure(let error):
                print(error)
            }
        }
        subscribeToMessagePublisher()
//        subscribeToMessagePublisher()
    }
    
    func sendMessage(text: String, completion:@escaping (Bool) -> Void){
        guard let user = AuthManager.shared.getCurrentUser() else {
           return
        }
        let msg = Message(userUid: user.uid, text: text, photoURL: user.photoURL, ceratedAt: Date())
        DatabaseManager.shared.sendMessageToDatabase(message: msg){ [weak self] success in
            if success {
                self?.messages.append(msg)
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func refresh() {
        self.messages = messages
    }
    
    private func subscribeToMessagePublisher(){
        DatabaseManager.shared.messagePublisher.receive(on: DispatchQueue.main)
            .sink{ completion in
                print(completion)
            } receiveValue: { [weak self] messages in
                self?.messages = messages
            }.store(in: &subcribers)
    }
}
