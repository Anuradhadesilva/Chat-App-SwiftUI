//
//  Message.swift
//  Chat-App-SwiftUI
//
//  Created by Anuradha Desilva on 11/03/2024.
//

import Foundation

struct Message:Decodable, Identifiable {
    var id = UUID()
    let userUid:String
    let text:String
    let photoURL:String
    let ceratedAt: Date
    
    func isFromCurrentUser () -> Bool {
        return false
    }
}
