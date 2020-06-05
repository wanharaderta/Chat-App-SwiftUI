//
//  LoginView.swift
//  Chat App
//
//  Created by Wanhar on 04/06/20.
//  Copyright © 2020 Wanhar. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct LoginView: View {
    
    private let colors = [
        Color(red: 29/255, green: 151/255, blue: 108/255),
        Color(red: 147/255, green: 249/255, blue: 185/255)
    ]
    
    @State var email = ""
    @State var password = ""
    @State var error = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: colors), startPoint: .bottom, endPoint: .top).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                HStack{
                    Text("Sign In").fontWeight(.heavy).font(.largeTitle).padding([.top,.bottom],20)
                }
                
                ZStack(alignment:.topLeading){
                    VStack {
                        VStack(alignment: .leading) {
                            Text("Username").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                            HStack{
                                TextField("Enter Your Username", text: $email)
                            }
                            
                            Divider()
                        }.padding(.bottom, 15)
                            .padding(.top,30)
                        
                        VStack(alignment: .leading) {
                            Text("Password").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                            HStack{
                                SecureField("Enter Your Password", text: $password)
                            }
                            
                            Divider()
                        }
                        
                        Button(action: {
                            Auth.auth().signIn(withEmail: self.email, password: self.password) { (result, err) in
                                if err != nil {
                                    self.error = (err?.localizedDescription)!
                                    return
                                }
                                
                                getUser { (success, name, pic) in
                                    if (success){
                                        UserDefaults.standard.set(true, forKey: "status")
                                        UserDefaults.standard.set(name, forKey: "name")
                                        UserDefaults.standard.set(name, forKey: "pic")
                                        
                                        NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                                        
                                        self.email      = ""
                                        self.password   = ""
                                    }
                                }
                            }
                            
                        }){
                            Text("Sign In").foregroundColor(.white).frame(width: UIScreen.main.bounds.width - 120).padding()
                        }.background(Color.blue)
                            .clipShape(Capsule())
                            .padding(.top, 45)
                        
                        VStack{
                            
                            HStack(spacing: 8){
                                Text("Don't Have An Account ?").foregroundColor(Color.black.opacity(0.5))
                                
                                Button(action: {
                                    //action
                                }) {
                                    Text("Sign Up")
                                }.foregroundColor(.blue)
                                
                            }.padding([.top,.bottom], 25)
                            
                        }.frame( alignment: .bottom)
                        
                    }
                    .padding(.horizontal, 30)
                    .background(CustomShape().fill(Color.white))
                    .clipShape(Corners())
                }
                .padding(15)
                //Spacer()
            }
            
            
        }.edgesIgnoringSafeArea(.top)
            .animation(.default)
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

func getUser(completion: @escaping (Bool, String, String) -> Void) {
    let db = Firestore.firestore()
    
    db.collection("users").getDocuments { (snap, err) in
        
        if err != nil {
            print((err?.localizedDescription)!)
            return
        }
        
        for i in snap!.documents {
            if i.documentID ==  Auth.auth().currentUser?.uid{
                completion(true, i.get("name") as! String,i.get("pic") as! String )
                return
            }
        }
        
        completion(false, "","")
        
    }
}
