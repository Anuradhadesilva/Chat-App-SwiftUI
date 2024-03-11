//
//  MessageView.swift
//  Chat-App-SwiftUI
//
//  Created by Anuradha Desilva on 11/03/2024.
//

import SwiftUI

struct MessageView: View {
    var message:Message
  
    var body: some View{
        if message.isFromCurrentUser(){
            HStack{
                HStack{
                    Text(message.text)
                        .padding()
                    
                }
                .frame(maxWidth: 260, alignment: .topLeading)
                .background(.gray)
                .cornerRadius(20)
                Image(systemName: "person.circle")
                    .frame(maxHeight: 50, alignment: .top)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding()
        } else {
            HStack{
                Image(systemName: "person.circle")
                    .frame(maxHeight: 50, alignment: .top)
                HStack{
                    Text(message.text)
                        .padding()
                    
                }
                .frame(maxWidth: 260, alignment: .leading)
                .background(.gray)
                .cornerRadius(20)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
    }
}

#Preview {
    MessageView(message: Message(userUid: "123", text: "Hello this is message from Anuradha", photoURL: "", ceratedAt: Date()))
}
