//
//  AuthManager.swift
//  Chat-App-SwiftUI
//
//  Created by Anuradha Desilva on 12/03/2024.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

struct chatUser {
    let uid:String
    let name:String
    let email:String
    let photoURL:String
    
}
enum GoogleSignInError: Error{
    case unableToGrabRootView
    case signInPresentationError
    case authSignInError
}

class AuthManager:ObservableObject {
    @Published var showSignIn = true
    static let shared = AuthManager()
    
    func getCurrentUser() -> chatUser? {
        guard let authUser = Auth.auth().currentUser else {
            return nil
        }
        return chatUser(uid: authUser.uid, name: authUser.displayName ?? "unknown", email: authUser.email ?? "unknown", photoURL: authUser.photoURL?.absoluteString ?? "unknown")
    }
    
    func signInWithGoogle()  async -> Bool{
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            fatalError("No Client Id found in firebase configuration")
        }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let windowScence = await UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = await windowScence.windows.first,
              let rootViewController = await window.rootViewController else {
            print("Their is no root view controller")
            return false
        }
        do{
            let userAuthentication = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
            let user = userAuthentication.user
            guard let idToken = user.idToken else {
                return false
            }
            let accessToken = user.accessToken
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
                                                                       accessToken: accessToken.tokenString)
            let result = try await Auth.auth().signIn(with: credential)
            
            let firebaseUser = chatUser(uid: result.user.uid, name: result.user.displayName ?? "unknown", email: result.user.email ?? "unknown", photoURL: result.user.photoURL?.absoluteString ?? "unknown")
            showSignIn = false
            print(showSignIn)
            return true
        }
        catch{
            print(error.localizedDescription)
            return false
        }
    }
    
    func logOut() {
        do{
            try Auth.auth().signOut()
        }
        catch{
            print(error)
        }
    }
}
