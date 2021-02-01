//
//  MMessage.swift
//  BanGipsChat
//
//  Created by BanGips on 1.02.21.
//

import UIKit

struct MMessage: Hashable {
    let content: String
    let senderId: String
    let senderUsername: String
    let sentDate: Date
    let id: String?
    
    var representation: [String: Any] {
        var rep: [String: Any] = [
            "created": sentDate,
            "senderID": senderId,
            "senderName": senderUsername,
            "content": content
        ]
        return rep 
    }
    
    init(user: MUser, content: String) {
        self.content = content
        self.senderId = user.id
        self.senderUsername = user.username
        self.sentDate = Date()
        self.id = nil
    }
}


