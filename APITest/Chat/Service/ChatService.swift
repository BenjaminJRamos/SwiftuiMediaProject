//
//  ChatService.swift
//  APITest
//
//  Created by Benjamin  Ramos on 12/19/23.
//

import Foundation
import Firebase
import FirebaseFirestore

struct ChatService {
    
    //SEND MESSAGE FUNCTION
    
    let chatPartner: User_fornow
    
    mutating func sendMessage(_ messageText: String) {
        
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        
        let chatPartnerId = chatPartner.id
        
         let currentUserRef = FirestoreConstants.MessagesCollection.document(currentUid).collection(chatPartnerId).document()
        
         let chatPartnerRef = FirestoreConstants.MessagesCollection.document(chatPartnerId).collection(currentUid)
         
         let recentCurrentUserRef = FirestoreConstants.MessagesCollection.document(currentUid).collection("recent-messages").document(chatPartnerId)
         
         let recentPartnerRef = FirestoreConstants.MessagesCollection.document(chatPartnerId).collection("recent-messages").document(currentUid)
        
        let messageId = currentUserRef.documentID
        
         let message = Message_ForNow(MessageId: messageId, fromId: currentUid, toId: chatPartnerId, messageText: messageText, timestamp: Timestamp())
        
        guard let messageData = try? Firestore.Encoder().encode(message) else {return}
        
        currentUserRef.setData(messageData)
        chatPartnerRef.document(messageId).setData(messageData)
         
         recentCurrentUserRef.setData(messageData)
         recentPartnerRef.setData(messageData)
    }
    
    // MESSAGE LISTENER
     func observeMessages(completion: @escaping ([Message_ForNow]) -> Void )  {
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        let chatPartnerId = chatPartner.id
        
         let query = FirestoreConstants.MessagesCollection.document(currentUid).collection(chatPartnerId).order(by: "timestamp", descending: false)
        
        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({$0.type == .added}) else {return}
            
            var messages = changes.compactMap({ try? $0.document.data(as: Message_ForNow.self)})
            
            for(index, message) in messages.enumerated() where message.fromId != currentUid {
                messages[index].user = chatPartner
            }
            completion(messages)
        }
    }
}
