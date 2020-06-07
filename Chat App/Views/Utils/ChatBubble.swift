//
//  ChatBubble.swift
//  Chat App
//
//  Created by Wanhar on 06/06/20.
//  Copyright © 2020 Wanhar. All rights reserved.
//

import SwiftUI

struct ChatBubble : Shape {
    
    var msg : Bool
    
    func path(in rect: CGRect) -> Path {
            
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight,msg ? .bottomLeft : .bottomRight], cornerRadii: CGSize(width: 16, height: 16))
        
        return Path(path.cgPath)
    }
}
