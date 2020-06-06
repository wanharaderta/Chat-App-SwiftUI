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
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    //@State var myuid = UserDefaults.standard.value(forKey: "UserName") as! String
    @State var chat = false
    @State var uid  = ""
    @State var name = ""
    @State var pic  = ""
    
    var body: some View {
        
        ZStack {
            NavigationLink(destination: ChatRoomView(viewModel: ChatRoomViewModel(), name: self.name, pic: self.pic, uid: self.uid, chat: $chat), isActive: self.$chat){
                Text("")
            }
            VStack {
                if self.homeViewModel.recents.count == 0 {
                    Text("No Chat History")
                } else {
                    ScrollView(.vertical, showsIndicators: false){
                        VStack(spacing: 16) {
                            ForEach(homeViewModel.recents.sorted(by: {$0.stamp > $1.stamp})){ i in
                                Button(action : {
                                    self.uid    = i.id
                                    self.name   = i.name
                                    self.pic    = i.pic
                                    self.chat.toggle()
                                }) {
                                    ChatCell(pic: i.pic, name: i.name, time: i.time, date: i.date, lastmsg: i.lastmsg)
                                }
                            }
                        }.padding()
                    }
                }
            }.navigationBarTitle("Home",displayMode: .inline)
                .navigationBarItems(trailing:
                    Button(action: self.homeViewModel.logout, label: {
                        Text("Logout")
                    })
            )
        }
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

#if DEBUG
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        //  HomeView().environmentObject(HomeViewModel())
        HomeView(homeViewModel: .init(), chat: false, uid: "", name: "", pic: "")
    }
}
#endif
