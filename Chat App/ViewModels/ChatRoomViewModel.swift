//
//  ChatRoomViewModel.swift
//  Chat App
//
//  Created by Wanhar on 06/06/20.
//  Copyright © 2020 Wanhar. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ChatRoomViewModel : ObservableObject {
    
    @Published var messages = [Messages]()
    
    
    func getMessages(id:String) {
        
        let db  = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        
        db.collection("msgs").document(uid!).collection(id).order(by: "date",descending: false).addSnapshotListener { (snap, err) in
            if err != nil {
                print((err?.localizedDescription))
                return
            }
            
            for i in snap!.documentChanges {
                if i.type == .added  {
                    let id      = i.document.documentID
                    let msg     = i.document.get("msg") as! String
                    let user    = i.document.get("user") as! String
                    
                    self.messages.append(Messages(id: id, message: msg, user: user))
                }
            }
        }
    }
    
    func sendMessage(user: String, uid: String, pic: String, date: Date, msg: String, name:String) {
        let db  = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        db.collection("users").document(uid).collection("recents").document(self.uid!).getDocument { (snap, err) in
            if err != nil {
                print((err?.localizedDescription))
                return
            }
            
            if snap!.exists {
                self.setRecents(user: user, uid: uid, pic: pic, date: date, msg: msg)
            } else {
                
            }
        }
    }
    
    func setRecents(user: String, id: String, pic: String, date: Date, msg: String) {
        let db  = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
       //db.collection("users").document(uid).collection("recents").document(id)
    }
    
    func updateRecents(uid:String, lastmsg:String, date:Date) {
        let db  = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
      //  db.collection("users").document(uid).collection("recents").document(self.uid!)
    }
}
