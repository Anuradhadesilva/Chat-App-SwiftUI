//
//  ChatViewModel.swift
//  Chat-App-SwiftUI
//
//  Created by Anuradha Desilva on 11/03/2024.
//

import Foundation

class ChatViewModel:ObservableObject{
    @Published var messages = [Message]()
    
    @Published var mockData = [
        Message(userUid: "123", text: "HI, How are you ?", photoURL: "", ceratedAt: Date()),
        Message(userUid: "123", text: "Where are you from?", photoURL: "", ceratedAt: Date()),
        Message(userUid: "123", text: "I am from Katubedda", photoURL: "", ceratedAt: Date()),
        Message(userUid: "123", text: "HI, How are you", photoURL: "", ceratedAt: Date()),
        
    ]
    
    func sendMessage(text: String){
        print(text)
    }
}
