//
//  MMessage.swift
//  BanGipsChat
//
//  Created by BanGips on 1.02.21.
//

import UIKit
import FirebaseFirestore
import MessageKit


struct ImageItem: MediaItem {
    var url: URL?
    var image: UIImage?
    var placeholderImage: UIImage
    var size: CGSize
    
    
}

struct MMessage: Hashable, MessageType {
        
    var messageId: String {
        return id ?? UUID().uuidString
    }
    
    var sender: SenderType
    let content: String
    let sentDate: Date
    let id: String?
    
    var image: UIImage? = nil
    var downloadURL: URL? = nil
    
    var representation: [String: Any] {
        var rep: [String: Any] = [
            "created": sentDate,
            "senderID": sender.senderId,
            "senderName": sender.displayName,
        ]
        
        if let url = downloadURL {
            rep["url"] = url.absoluteString
        } else {
            rep["content"] = content
        }
        
        return rep 
    }
    
    var kind: MessageKind {
        if let image = image {
            let mediaImage = ImageItem(url: nil, image: image, placeholderImage: image, size: image.size)
            return .photo(mediaImage)
        } else {
            return .text(content)
        }
    }
    
    init(user: MUser, content: String) {
        self.content = content
        self.sender = Sender(senderId: user.id, displayName: user.username)
        self.sentDate = Date()
        self.id = nil
    }
    
    init(user: MUser, image: UIImage) {
        self.sender = Sender(senderId: user.id, displayName: user.username)
        self.content = ""
        self.image = image
        self.sentDate = Date()
        self.id = nil
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let sentDate = data["created"] as? Timestamp,
              let senderId = data["senderID"] as? String,
              let senderName = data["senderName"] as? String  else {
            return nil
        }
        
        self.id = document.documentID
        self.sentDate = sentDate.dateValue()
        self.sender = Sender(senderId: senderId, displayName: senderName)
        if let content = data["content"] as? String {
            self.content = content
            downloadURL = nil
        } else if let urlString = data["url"] as? String, let url = URL(string: urlString) {
            downloadURL = url
            self.content = ""
        } else {
            return nil
        }
        
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(messageId)
    }
    
    static func == (lhs: MMessage, rhs: MMessage) -> Bool {
        return lhs.messageId == rhs.messageId
    }
}

extension MMessage: Comparable {
    static func < (lhs: MMessage, rhs: MMessage) -> Bool {
        lhs.sentDate < rhs.sentDate
    }
    
    
}


