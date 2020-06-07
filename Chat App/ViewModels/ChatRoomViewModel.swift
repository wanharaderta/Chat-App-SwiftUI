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
    @Published var noMsgs = false
    
    func getMessages(id:String) {
        
        let db  = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        
        db.collection("msgs").document(uid!).collection(id).order(by: "date",descending: false).addSnapshotListener { (snap, err) in
            if err != nil {
                print((err?.localizedDescription))
                return
            }
            
            if snap!.isEmpty {
                self.noMsgs = true
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
    
    func sendMessage(user: String, id: String, pic: String, msg: String) {
        let db  = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        db.collection("users").document(id).collection("recents").document(uid!).getDocument{ (snap, err) in
            if err != nil {
                print((err?.localizedDescription) ?? "")
                self.setRecents(user: user, id: id, pic: pic, date: Date(), msg: msg)
                return
            }
            
            if snap!.exists {
                self.setRecents(user: user, id: id, pic: pic, date: Date(), msg: msg)
            } else {
                self.updateRecents(id: id, lastmsg: msg, date: Date())
            }
        }
        
        updateDB(id: id, msg: msg, date: Date())
    }
    
    func setRecents(user: String, id: String, pic: String, date: Date, msg: String) {
        let db  = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        db.collection("users").document(id).collection("recents").document(uid!).setData(["name":user,"pic":pic,"lastmsg":msg,"date":date]) { (err) in
            if err != nil {
                print((err?.localizedDescription) ?? "")
                return
            }
        }
    }
    
    func updateRecents(id:String, lastmsg:String, date:Date) {
        let db  = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        db.collection("users").document(id).collection("recents").document(uid!).updateData(["lastmsg":lastmsg,date:date])
        db.collection("users").document(uid!).collection("recents").document(id).updateData(["lastmsg":lastmsg,date:date])
    }
    
    func updateDB(id:String, msg:String, date:Date){
        let db  = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        db.collection("msgs").document(id).collection(uid!).document().setData(["msg":msg,"user":id,"date":date]) { (err) in
            if err != nil {
                print((err?.localizedDescription) ?? "")
                return
            }
        }
        db.collection("msgs").document(uid!).collection(id).document().setData(["msg":msg,"user":id,"date":date]) { (err) in
            if err != nil {
                print((err?.localizedDescription) ?? "")
                return
            }
        }
    }
}
