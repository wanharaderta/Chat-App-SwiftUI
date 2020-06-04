//
//  HomeView.swift
//  Chat App
//
//  Created by Wanhar on 04/06/20.
//  Copyright © 2020 Wanhar. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    
    @EnvironmentObject var authViewModel:AuthViewModel
    @EnvironmentObject var chats : ChatViewModel
    
    func getUser() {
        authViewModel.listen()
    }
    
    var body: some View {
        Group {
            if(authViewModel.session != nil){
                VStack {
                    List(chats.recents) { i in
                        ChatCell(url: i.pic, name: i.name, time: i.time, date: i.date, lastmsg: i.lastmsg)
                    }
                }
            } else {
                LoginView()
            }
        }.onAppear(perform: getUser)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


struct ChatCell: View {
    
    var url     : String
    var name    : String
    var time    : String
    var date    : String
    var lastmsg : String
    
    
    
    var body: some View {
        HStack {
            AnimatedImage(url: URL(string: url)!)
            .resizable()
                .renderingMode(.original)
            .frame(width: 55, height: 55)
            
            VStack {
                HStack{
                    VStack(alignment: .leading, spacing: 6)  {
                        Text(name)
                        Text(lastmsg).foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 6)  {
                        Text(date).foregroundColor(.gray)
                        Text(time).foregroundColor(.gray)
                    }
                    
                }
            }
        }
    }
}
