//
//  DatabaseManger.swift
//  Chat-App-SwiftUI
//
//  Created by Anuradha Desilva on 12/03/2024.
//
import Combine
import Foundation
import FirebaseFirestore

enum FetchMessageError: Error{
    case snapshotError
}
final class DatabaseManager {
    static let shared = DatabaseManager()
    
    let messageRef = Firestore.firestore().collection("messages")
    
    var messagePublisher = PassthroughSubject<[Message], Error>()
    
    func fetchMessages(completion:@escaping (Result <[Message], FetchMessageError>) -> Void){
        messageRef.order(by:"createdAt", descending: true).limit(to: 25).getDocuments{ [weak self] snapshot, error in
            guard let snapshot = snapshot, let strongSelf = self, error == nil else  {
                completion(.failure(.snapshotError))
                return
            }
            strongSelf.ListenToNewMassages()
            let messages = strongSelf.createMessageFromSnapShot(snapshot: snapshot)
            completion(.success(messages))
        }
    }
    
    func sendMessageToDatabase(message: Message, completion:@escaping (Bool) -> Void){
        let data = [
            "text" : message.text,
            "userUid": message.userUid,
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
    
    func ListenToNewMassages(){
        messageRef.order(by:"createdAt", descending: true).limit(to: 25).addSnapshotListener{ [weak self] snapshot, error in
            guard let snapshot = snapshot, let strongSelf = self, error == nil else {
                return
            }
            let messages = strongSelf.createMessageFromSnapShot(snapshot: snapshot)
            strongSelf.messagePublisher.send(messages)
        }
    }
    
    func createMessageFromSnapShot(snapshot: QuerySnapshot) -> [Message]{
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
        return messages.reversed()
    }
}
