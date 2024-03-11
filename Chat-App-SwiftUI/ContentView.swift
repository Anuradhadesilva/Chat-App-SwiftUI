//
//  ContentView.swift
//  Chat-App-SwiftUI
//
//  Created by Anuradha Desilva on 11/03/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var chatViewModel:ChatViewModel
    @ObservedObject var authModel:AuthManager
//    @State private var showSignIn = true
    var body: some View {
        NavigationStack{
            ZStack {
                ChatView(chatViewModel: ChatViewModel())
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Chat Room")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Text("Sign Out")
                        .foregroundStyle(.red)
                        .onTapGesture {
                            authModel.logOut()
                            authModel.showSignIn = true
                        }
                    
                }
            }
            .fullScreenCover(isPresented: $authModel.showSignIn){
                SignInView(authModel: authModel)
            }
        }
        .onAppear{
            authModel.showSignIn = authModel.getCurrentUser() == nil
        }
    }
}

//#Preview {
//    ContentView(chatViewModel: ChatViewModel())
//}
