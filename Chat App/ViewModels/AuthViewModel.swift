//
//  SessionStoreViewModel.swift
//  Chat App
//
//  Created by Wanhar on 03/06/20.
//  Copyright © 2020 Wanhar. All rights reserved.
//

import Firebase
import Combine

class AuthViewModel: ObservableObject {
    var didChange   = PassthroughSubject<AuthViewModel, Never>()
    var handle      : AuthStateDidChangeListenerHandle?
    @Published var session: User? {
        didSet {
            self.didChange.send(self)
        }
    }
    
    func listen() {
        handle  = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if let user = user {
                self.session    = User(uid: user.uid, email: user.email)
            } else {
                self.session = nil
            }
        })
    }
    
    func signIn(email:String, password:String, handle : @escaping AuthDataResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handle)
        
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch{
            print("Error login!!!")
        }
    }
    
    func unbind(){
        if let handle   = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    deinit {
        unbind()
    }
    
    
}
