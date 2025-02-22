//
//  Message.swift
//  APITest
//
//  Created by Benjamin  Ramos on 12/19/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Message_ForNow: Identifiable, Codable, Hashable {
    @DocumentID var MessageId: String?
    let fromId: String
    let toId: String
    let messageText: String
    let timestamp: Timestamp
  
    var user: User_fornow?
    
    var id: String {
        return MessageId ?? NSUUID().uuidString
    }
    
    var ChatPartnerId: String {
        return fromId == Auth.auth().currentUser?.uid ? toId : fromId
    }
    
    var isFromCurrentUser: Bool {
        return fromId == Auth.auth().currentUser?.uid
    }
    
    var timeStampString: String{
        return timestamp.dateValue().timeStampString()
    }
}

extension Message_ForNow {
    static var Mock_Messages: [Message_ForNow] = [
        .init(
            MessageId: NSUUID().uuidString,
            fromId: NSUUID().uuidString,
            toId: NSUUID().uuidString,
            messageText: "Yo look at this text message",
            timestamp: Timestamp(),
            user: User_fornow.Mock_USERS[1])
        
    ]
    
}


