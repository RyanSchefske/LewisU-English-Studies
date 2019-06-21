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
    var messageId: String
    var sentDate: Date
    var sender: SenderType
    
    init(member: Member, content: String, date: Date) {
        self.member = Member(name: member.name)
        self.text = content
        self.sentDate = date
        self.messageId = UUID().uuidString
        self.sender = Sender(id: member.name, displayName: member.name)
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
        sender = Sender(id: member.name, displayName: member.name)
        sentDate = date
        messageId = document.documentID
        
        if let content = data["content"] as? String {
            self.text = content
        } else {
            return nil
        }
    }
}

extension Message: MessageType {
    
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
        return lhs.messageId == rhs.messageId
    }
    static func < (lhs: Message, rhs: Message) -> Bool {
        return lhs.sentDate < rhs.sentDate
    }
}

