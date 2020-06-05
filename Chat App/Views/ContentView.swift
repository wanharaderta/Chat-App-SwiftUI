//
//  ContentView.swift
//  Chat App
//
//  Created by Wanhar on 05/06/20.
//  Copyright © 2020 Wanhar. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    
    @State var status   = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    
    var body: some View {
        VStack {
            if(status){
                NavigationView {
                    HomeView().environmentObject(ChatViewModel())
                }
            } else {
                LoginView()
            }
        }.onAppear{
            NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"), object: nil, queue: .main) { (_) in
                
                let status   = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                self.status = status
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

