//
//  ChatRoomView.swift
//  Chat App
//
//  Created by Wanhar on 06/06/20.
//  Copyright © 2020 Wanhar. All rights reserved.
//

import SwiftUI

struct ChatRoomView : View {
    
    @ObservedObject var viewModel: ChatRoomViewModel
    
    var name            : String
    var pic             : String
    var uid             : String
    @Binding var chat   : Bool
    @State var txt      = ""
    
    var body : some View {
        
        VStack {
            if viewModel.messages.count == 0 {
                Spacer()
                Text("Start New Conversation !!!").foregroundColor(Color.black.opacity(0.5)).padding(.top)
                Spacer()
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 8) {
                        ForEach(viewModel.messages){ i in
                            HStack {
                                if i.id == UserDefaults.standard.value(forKey: "UID") as! String {
                                    
                                    Spacer()
                                    
                                    Text(i.message)
                                        .padding().background(Color.white)
                                        .clipShape(ChatBubble(msg: true))
                                        .foregroundColor(.green)
                                        
                                } else {
                                    Text(i.message)
                                        .padding().background(Color.gray)
                                        .clipShape(ChatBubble(msg: true))
                                        .foregroundColor(.white)
                                        
                                    Spacer()
                                }
                            }
                        }
                    }
                }
            }
            
            HStack {
                TextField("Enter Message",text: self.$txt)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    
                }) {
                    Text("Send")
                }
            }.padding()
            
//            navigationBarTitle("\(name)", displayMode: .inline)
//                .navigationBarItems(leading: Button(action: {
//                    self.chat.toggle()
//                }, label: {
//                    Image(systemName: "arrow.left")
//                        .resizable()
//                        .frame(width: 20, height: 20)
//                }))
            
        }.padding()
            .onAppear{
                self.viewModel.getMessages(id: self.uid)
        }
    }
}
