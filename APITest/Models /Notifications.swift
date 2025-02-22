//
//  Notifications.swift
//  APITest
//
//  Created by Benjamin  Ramos on 1/4/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Notification_ForNow: Identifiable, Hashable, Codable {
    
    @DocumentID var NotificationId: String?
    let fromId: String
    let toId: String
    let timestamp: Timestamp
   
    
    var user: User_fornow?
    
    var id: String {
        return NotificationId ?? NSUUID().uuidString
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

extension Notification_ForNow {
    static var Mock_Notifications: [Notification_ForNow] = [
        .init(
            NotificationId: NSUUID().uuidString,
              fromId: NSUUID().uuidString,
              toId: NSUUID().uuidString,
             timestamp: Timestamp(),
              user: User_fornow.Mock_USERS[0]
             )
        ]
    }
