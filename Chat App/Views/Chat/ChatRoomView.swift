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
                if (viewModel.noMsgs) {
                    Spacer()
                    Text("Start New Conversation !!!").foregroundColor(Color.black.opacity(0.5)).padding(.top)
                    Spacer()
                } else {
                    Spacer()
                    Indicator()
                    Spacer()
                    
                }
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 8) {
                        ForEach(viewModel.messages){ i in
                            HStack {
                                if i.user == UserDefaults.standard.value(forKey: "UID") as! String {
                                    
                                    Spacer()
                                    
                                    Text(i.message)
                                        .padding().background(Color.green)
                                        .clipShape(ChatBubble(msg: true))
                                        .foregroundColor(.white)
                                    
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
                    self.viewModel.sendMessage(user: self.name, id: self.uid, pic: self.pic, msg: self.txt)
                    self.txt = ""
                }) {
                    Text("Send")
                }
            }.padding()
                
                
            
        }
        .navigationBarTitle("\(name)", displayMode: .inline)
        .padding()
            .onAppear{
                self.viewModel.getMessages(id: self.uid)
        }
    }
}
