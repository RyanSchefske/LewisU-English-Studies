//
//  Messages.swift
//  EnglishStudies
//
//  Created by Ryan Schefske on 6/18/19.
//  Copyright © 2019 Ryan Schefske. All rights reserved.
//

import UIKit
import MessageKit
import Firebase
import FirebaseFirestore

struct Member {
    let name: String
}

struct Message {
    var member: Member
    let text: String
    let messageId: String
    var sentDate: Date
    
    init(member: Member, content: String) {
        self.member = Member(name: member.name)
        self.text = content
        self.sentDate = Date()
        self.messageId = UUID().uuidString
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let date = data["created"] as? Date else {
            return nil
        }
        guard let senderName = data["senderName"] as? String else {
            return nil
        }
        
        member = Member(name: senderName)
        sentDate = date
        messageId = UUID().uuidString
        
        if let content = data["content"] as? String {
            self.text = content
        } else {
            return nil
        }
    }
}

extension Message: MessageType {
    var sender: SenderType {
        return Sender(id: member.name, displayName: member.name)
    }
    
//    var sentDate: Date {
//        return Date()
//    }
    
    var kind: MessageKind {
        return .text(text)
    }
}

extension Message: DatabaseRepresentation {
    
    var representation: [String : Any] {
        var rep: [String : Any] = [
            "created": sentDate,
            "senderName": sender.displayName
        ]
        rep["content"] = text
        return rep
    }
}

extension Message: Comparable {
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.sentDate == rhs.sentDate
    }
    static func < (lhs: Message, rhs: Message) -> Bool {
        return lhs.sentDate < rhs.sentDate
    }
}

