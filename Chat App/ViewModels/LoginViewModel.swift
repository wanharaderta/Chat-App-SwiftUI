//
//  SessionStoreViewModel.swift
//  Chat App
//
//  Created by Wanhar on 03/06/20.
//  Copyright © 2020 Wanhar. All rights reserved.
//

import Firebase
import FirebaseFirestore

//func getUser(completion: @escaping (Bool, String) -> Void) {
//    let db = Firestore.firestore()
//    
//    db.collection("users").getDocuments { (snap, err) in
//        
//        if err != nil {
//            print((err?.localizedDescription)!)
//            return
//        }
//        
//        for i in snap!.documents {
//            if i.documentID ==  Auth.auth().currentUser?.uid{
//                completion(true, i.get("user") as! String)
//                return
//            }
//        }
//        
//        completion(false, "")
//        
//    }
//}
