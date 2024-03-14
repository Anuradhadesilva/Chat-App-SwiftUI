//
//  ChatView.swift
//  Chat-App-SwiftUI
//
//  Created by Anuradha Desilva on 11/03/2024.
//

import SwiftUI

struct ChatView: View {
    
    @StateObject var chatViewModel:ChatViewModel
    @State var text = ""
    var body: some View {
        VStack{
            ScrollViewReader{ scrollView in
                ScrollView(showsIndicators: false){
                    VStack(spacing: 8){
                        ForEach(Array(chatViewModel.messages.enumerated()), id: \.element) {index, message in
                            MessageView(message: message)
                                .id(index)
                        }
                        .onChange(of: chatViewModel.messages){ newValue in
                            scrollView.scrollTo(chatViewModel.messages.count , anchor: .bottom)
                        }
                    }
                }
            }
            .scrollDismissesKeyboard(.interactively)

            HStack{
                TextField("Hello there", text: $text, axis: .vertical)
                    .padding()
                Button{
                    chatViewModel.sendMessage(text: text) { success in
                        if success {
                            
                        }else {
                            print("error sending message")
                        }
                    }
                    text = ""
                }label: {
                       Text("Send")
                        .frame(width:80, height: 50)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(50.0)
                }
                .padding()
            }
            .background(Color(UIColor.systemGray6))
            .cornerRadius(6.0)
        }
    }
}

#Preview {
   ChatView(chatViewModel: ChatViewModel())
}
