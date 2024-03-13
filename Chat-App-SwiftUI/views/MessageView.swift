//
//  MessageView.swift
//  Chat-App-SwiftUI
//
//  Created by Anuradha Desilva on 11/03/2024.
//

import SwiftUI
import SDWebImageSwiftUI
import SDWebImage

struct MessageView: View {
    var message:Message
  
    var body: some View{
        if message.isFromCurrentUser(){
            HStack{
                HStack{
                    Text(message.text)
                        .padding()
                        .background(Color(uiColor:.systemBlue))
                        .cornerRadius(20)
                    
                }
                .frame(maxWidth: 260, alignment: .trailing)
                if let photURl = message.fetchPhotoURL() {
                    WebImage(url: photURl)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 32, maxHeight: 32,  alignment:.trailing)
                        .cornerRadius(16)
                } else {
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 32, maxHeight: 32,  alignment:.trailing)
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.horizontal)
        } else {
            HStack{
                if let photURl = message.fetchPhotoURL() {
                    WebImage(url: photURl)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 32, maxHeight: 32,  alignment:.trailing)
                        .cornerRadius(16)
                } else {
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 32, maxHeight: 32,  alignment:.top)
                }
                HStack{
                    Text(message.text)
                        .padding()
                        .background(Color(uiColor:.systemGray4))
                        .cornerRadius(20)
                }
                .frame(maxWidth: 260, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        }
    }
}

#Preview {
    MessageView(message: Message(userUid: "123", text: "Hello this is message from Anuradha", photoURL: "", ceratedAt: Date()))
}
