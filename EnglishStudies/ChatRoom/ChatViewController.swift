//
//  ChatViewController.swift
//  EnglishStudies
//
//  Created by Ryan Schefske on 6/12/19.
//  Copyright © 2019 Ryan Schefske. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import MessageKit
import InputBarAccessoryView

class ChatViewController: MessagesViewController {
    
    var messages: [Message] = []
    var member: Member!
    private let db = Firestore.firestore()
    private var reference: CollectionReference?
    private var messageListener: ListenerRegistration?
    
    var activityIndicatorView: UIActivityIndicatorView!
    let dispatchQueue = DispatchQueue(label: "Message Queue")
    
    deinit {
        messageListener?.remove()
    }
    
    init(member: Member) {
        self.member = member
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMessages()
        
        view.backgroundColor = .white
        navigationItem.title = "Chat"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signOutButtonPressed))
        messageInputBar.inputTextView.placeholderLabel.text = "Message"
        maintainPositionOnKeyboardFrameChanged = true
        messageInputBar.sendButton.setTitleColor(UIColor(red: 0, green: 122 / 255, blue: 1, alpha: 1), for: .normal)
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messageInputBar.delegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messageCellDelegate = self
    }
    
    func loadMessages() {
        self.reference = self.db.collection("messages")
        self.messageListener = self.reference?.addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error listening for channel updates: \(error?.localizedDescription ?? "No error")")
                return
            }
            
            snapshot.documentChanges.forEach { change in
                self.handleDocumentChange(change)
            }
        }
    }
    
    @objc func signOutButtonPressed() {
        do {
            self.navigationController?.popToRootViewController(animated: true)
            try Auth.auth().signOut()
        } catch {
            print("Error")
        }
    }
    
    private func save(_ message: Message) {
        reference?.addDocument(data: message.representation) { error in
            if let e = error {
                print("Error sending message: \(e.localizedDescription)")
                return
            }
            self.messagesCollectionView.scrollToBottom()
        }
    }
    
    func insertNewMessage(_ message: Message) {
        guard !messages.contains(message) else {
            return
        }
        
        messages.append(message)
        messages = messages.sorted(by: { $0.sentDate < $1.sentDate})

        messagesCollectionView.reloadData()
        DispatchQueue.main.async {
            self.messagesCollectionView.scrollToBottom(animated: true)
        }
    }
    
    func handleDocumentChange(_ change: DocumentChange) {
        let timestamp: Timestamp = change.document.get("created") as! Timestamp
        let date: Date = timestamp.dateValue()
        let newMessage = Message(member: Member(name: change.document.data()["senderName"] as! String), content: change.document.data()["content"] as! String, date: date)
        
        switch change.type {
            case .added:
                insertNewMessage(newMessage)
            default:
                break
        }
    }
}

extension ChatViewController: MessagesDataSource {
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func currentSender() -> SenderType {
        return Sender(id: member.name, displayName: member.name)
    }
    
    func messageForItem(
        at indexPath: IndexPath,
        in messagesCollectionView: MessagesCollectionView) -> MessageType {
        
        return messages[indexPath.section]
    }
    
    func messageTopLabelHeight(
        for message: MessageType,
        at indexPath: IndexPath,
        in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        
        return 15
    }
    
    func messageTopLabelAttributedText(
        for message: MessageType,
        at indexPath: IndexPath) -> NSAttributedString? {
        
        return NSAttributedString(
            string: message.sender.displayName,
            attributes: [.font: UIFont.systemFont(ofSize: 12)])
    }
}

extension ChatViewController: MessagesLayoutDelegate {
    
    func avatarSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return .zero
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        
        if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout {
            layout.textMessageSizeCalculator.outgoingAvatarSize = .zero
            layout.textMessageSizeCalculator.incomingAvatarSize = .zero
        }
    }
    
    func footerViewSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return CGSize(width: 0, height: 8)
    }
    
    func heightForLocation(message: MessageType, at indexPath: IndexPath, with maxWidth: CGFloat, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        
        return 0
    }
}

extension ChatViewController: MessagesDisplayDelegate {
    
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        if isFromCurrentSender(message: message) {
            return UIColor(red: 0, green: 122 / 255, blue: 1, alpha: 1)
        }
        return UIColor(red: 230 / 255, green: 230 / 255, blue: 230 / 255, alpha: 1)
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTail(corner, .curved)
    }
}

extension ChatViewController: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        let newMessage = Message(member: member, content: text, date: Date())
        
        save(newMessage)
        
        inputBar.inputTextView.text = ""
    }
}

extension ChatViewController: MessageCellDelegate {
    func didTapMessage(in cell: MessageCollectionViewCell) {
        if let indexPath = messagesCollectionView.indexPath(for: cell) {
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let reportAction = UIAlertAction(title: "Report message", style: .destructive) { (action) in
                print("didPress report")
                print(self.messages[indexPath.section].text)
                let reportRef = self.db.collection("messages")
                    .whereField("content", isEqualTo: self.messages[indexPath.section].text)
                    .whereField("senderName", isEqualTo: self.messages[indexPath.section].member.name)
                    .getDocuments(completion: { (querySnapshot, error) in
                    if error != nil {
                        print("Error")
                    } else if querySnapshot!.documents.count != 1 {
                        print("Error finding document")
                    } else {
                        let document = querySnapshot!.documents.first
                        if var reports = document!.data()["reports"] as? Int {
                            reports += 1
                            if reports >= 3 {
                                document?.reference.delete(completion: { (error) in
                                    if error != nil {
                                        print(error?.localizedDescription)
                                    } else {
                                        self.messagesCollectionView.reloadData()
                                    }
                                })
                            } else {
                                document?.reference.updateData([ "reports": reports])
                            }
                        }
                    }
                })
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                //Dismiss Alert
            }
            
            actionSheet.addAction(reportAction)
            actionSheet.addAction(cancelAction)
            self.present(actionSheet, animated: true, completion: nil)
        }
    }
}

