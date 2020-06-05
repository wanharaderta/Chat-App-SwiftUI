//
//  ChatViewModel.swift
//  Chat App
//
//  Created by Wanhar on 04/06/20.
//  Copyright © 2020 Wanhar. All rights reserved.
//

import SwiftUI
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

class ChatViewModel: ObservableObject  {
    
    @Published var recents   = [Recent]()
    
    init() {
        let db  = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        
        db.collection("users").document(uid!).collection("recents").order(by: "date",descending: true).addSnapshotListener{ (snap,error) in
            
            if error != nil {
                print((error?.localizedDescription))
                return
            }
            
            for i in snap!.documentChanges{
                
                let id         = i.document.documentID
                let name       = i.document.get("name") as! String
                let pic        = i.document.get("pic") as! String
                let lastmsg    = i.document.get("lastmsg") as! String
                let stamp      = i.document.get("date") as! Timestamp
                
                let formatter           = DateFormatter()
                formatter.dateFormat    = "dd/MM/yy"
                let date                = formatter.string(from: stamp.dateValue())
                
                formatter.dateFormat    = "hh:mm a"
                let time                = formatter.string(from: stamp.dateValue())
                
                self.recents.append(Recent(id: id, name: name, pic: pic, lastmsg: lastmsg, time: time, date: date, stamp: stamp.dateValue()))
            }
        }
    }
    
    func logout() {
        UserDefaults.standard.set("", forKey: "name")
        UserDefaults.standard.set("", forKey: "pic")
        
        try! Auth.auth().signOut()
        
        UserDefaults.standard.set(false, forKey: "status")
        
        NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
    }
    
}

