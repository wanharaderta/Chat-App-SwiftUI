//
//  HomeView.swift
//  Chat App
//
//  Created by Wanhar on 04/06/20.
//  Copyright © 2020 Wanhar. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import SDWebImageSwiftUI

struct HomeView: View {
    
    @EnvironmentObject var chatsViewModel : ChatViewModel
    
    var body: some View {
        VStack {
            if self.chatsViewModel.recents.count == 0 {
                Text("No Chat History")
            } else {
                ScrollView(.vertical, showsIndicators: false){
                    VStack(spacing: 16) {
                        ForEach(chatsViewModel.recents.sorted(by: {$0.stamp > $1.stamp})){ i in
                            ChatCell(pic: i.pic, name: i.name, time: i.time, date: i.date, lastmsg: i.lastmsg)
                        }
                    }.padding()
                }
            }
        }.navigationBarTitle("Home",displayMode: .inline)
        .navigationBarItems(trailing:
            Button(action: {
                UserDefaults.standard.set("", forKey: "name")
                UserDefaults.standard.set("", forKey: "pic")
                
                try! Auth.auth().signOut()
                
                UserDefaults.standard.set(false, forKey: "status")
                
                NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
            }, label: {
                Text("Logout")
            })
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


struct ChatCell: View {
    
    var pic     : String
    var name    : String
    var time    : String
    var date    : String
    var lastmsg : String
    
    var body : some View{
        
        HStack{
            
            AnimatedImage(url: URL(string: pic)!).resizable().renderingMode(.original).frame(width: 55, height: 55).clipShape(Circle())
            
            VStack{
                
                HStack{
                    
                    VStack(alignment: .leading, spacing: 6) {
                        
                        Text(name).foregroundColor(.black)
                        Text(lastmsg).foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 6) {
                        
                        Text(date).foregroundColor(.gray)
                        Text(time).foregroundColor(.gray)
                    }
                }
                
                Divider()
            }
        }
    }
}

