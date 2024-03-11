//
//  ChatView.swift
//  Chat-App-SwiftUI
//
//  Created by Anuradha Desilva on 11/03/2024.
//

import SwiftUI

struct ChatView: View {
    
    @ObservedObject var chatViewModel:ChatViewModel
    @State var text = ""
    var body: some View {
        VStack{
            ScrollView(showsIndicators: false){
                VStack(spacing: 8){
                    ForEach(chatViewModel.mockData) {message in
                        MessageView(message: message)
                    }
                }
            }
            HStack{
                TextField("Hello there", text: $text, axis: .vertical)
                    .padding()
                Button{
                    chatViewModel.sendMessage(text: text)
                }label: {
                       Text("Send")
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(50.0)
                }
            }
            .background(Color(UIColor.systemGray6))
            .cornerRadius(6.0)
        }
    }
}

#Preview {
   ChatView(chatViewModel: ChatViewModel())
}
