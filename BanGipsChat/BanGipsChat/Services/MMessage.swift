//
//  MMessage.swift
//  BanGipsChat
//
//  Created by BanGips on 1.02.21.
//

import UIKit
import FirebaseFirestore
import MessageKit

struct MMessage: Hashable, MessageType {
        
    var messageId: String {
        return id ?? UUID().uuidString
    }
    
    var sender: SenderType
    let content: String
    let sentDate: Date
    let id: String?
    
    var kind: MessageKind {
        return .text(content)
    }
    
    var representation: [String: Any] {
        let rep: [String: Any] = [
            "created": sentDate,
            "senderID": sender.senderId,
            "senderName": sender.displayName,
            "content": content
        ]
        return rep 
    }
    
    init(user: MUser, content: String) {
        self.content = content
        self.sender = Sender(senderId: user.id, displayName: user.username)
        self.sentDate = Date()
        self.id = nil
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let sentDate = data["created"] as? Timestamp,
              let senderId = data["senderID"] as? String,
              let senderName = data["senderName"] as? String,
              let content = data["content"] as? String else {
            return nil
        }
        
        self.id = document.documentID
        self.sentDate = sentDate.dateValue()
        self.sender = Sender(senderId: senderId, displayName: senderName)
        self.content = content 
        
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(messageId)
    }
    
    static func == (lhs: MMessage, rhs: MMessage) -> Bool {
        return lhs.messageId == rhs.messageId
    }
}


