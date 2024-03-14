//
//  Message.swift
//  Chat-App-SwiftUI
//
//  Created by Anuradha Desilva on 11/03/2024.
//

import Foundation

struct Message : Decodable, Identifiable,Equatable, Hashable{
    let id = UUID()
    let userUid:String
    let text:String
    let photoURL:String?
    let ceratedAt: Date
    
    func isFromCurrentUser () -> Bool {
        guard let currUser = AuthManager.shared.getCurrentUser() else {
            return false
        }
        if currUser.uid == userUid {
            return true
        } else {
            return false
        }
    }
    
    func fetchPhotoURL() -> URL? {
        guard let photURLString = photoURL , let url = URL(string: photURLString) else {
            return nil
        }
        return url
    }
}
