//
//  DatabaseManger.swift
//  Chat-App-SwiftUI
//
//  Created by Anuradha Desilva on 12/03/2024.
//

import Foundation
import FirebaseFirestore
final class DatabaseManager {
    static let shared = DatabaseManager()
    
    let messageRef = Firestore.firestore().collection("messages")
    
    func fetchMessages(completion:@escaping (Result <[Message], Error>) -> Void){
        messageRef.order(by:"createdAt", descending: true).limit(to: 25).getDocuments{ snapshot, error in
            guard let snapshot = snapshot, error == nil else {
                return
            }
            let docs = snapshot.documents
            var messages = [Message]()
            
            for doc in docs {
                let data = doc.data()
                let text = data["text"] as? String ?? "Error"
                let userUid = data["userUid"] as? String ?? "Error"
                let photoURL = data["photoURL"] as? String ?? "Error"
                let createdAt = data["createdAt"] as? Timestamp ?? Timestamp()
                
                let msg = Message(userUid: userUid, text: text, photoURL: photoURL, ceratedAt: createdAt.dateValue())
                messages.append(msg)
            }
        }
    }
    
    func sendMessageToDatabase(message: Message, completion:@escaping (Bool) -> Void){
        let data = [
            "text" : message.text,
            "userId": message.userUid,
            "photoURL": message.photoURL,
            "createdAt": Timestamp(date: message.ceratedAt)
        ] as [String : Any]
        messageRef.addDocument(data: data) { error in
            guard error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
        
    }
}
