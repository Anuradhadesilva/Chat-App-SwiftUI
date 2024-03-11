//
//  SignInView.swift
//  Chat-App-SwiftUI
//
//  Created by Anuradha Desilva on 12/03/2024.
//

import SwiftUI
import Combine
import AuthenticationServices

struct SignInView: View {
    @ObservedObject var authModel:AuthManager
//    @Binding var showSignIn: Bool
    private func signInWithGoogle(){
        Task{
            if await authModel.signInWithGoogle() == true {
                
            }
        }
    }
    var body: some View {
        VStack{
            Button{
                signInWithGoogle()
            }label: {
                ZStack{
                    RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                        .stroke()
                        .frame(minWidth:0 , maxWidth:.infinity, minHeight: 0, maxHeight: 50)
                        .padding(.horizontal,20)
                        .foregroundColor(.primary)
                        
                    HStack{
                        Image("google")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding()
                        Text("Sign In With Google")
                            .foregroundColor(.black)
                    }
                }
            }
            Button{
                
            }label: {
                ZStack{
                    RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                        .stroke()
                        .frame(minWidth:0 , maxWidth:.infinity, minHeight: 0, maxHeight: 50)
                        .padding(.horizontal,20)
                        .foregroundColor(.primary)
                    HStack{
                        Image("apple")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding()
                        Text("Sign In With Apple")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}
//
//#Preview {
//    SignInView()
//}
