//
//  notificationService.swift
//  APITest
//
//  Created by Benjamin  Ramos on 1/4/24.
//

import Foundation
import Firebase
import FirebaseFirestore

struct notificationService {
    
    let user: User_fornow
    
    // SENDING NOTIFICATION COLLECTION TO FIRESTORE:
    func applyToTheJob(post: Post) {
        
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        
        let chatPartnerId = post.ownerUid
        
        let currentUserRef = FirestoreConstants.NotificationCollection.document()
        
        let notificationId = currentUserRef.documentID
        
        let notification = Notification_ForNow(NotificationId: notificationId, fromId: currentUid, toId: chatPartnerId, timestamp: Timestamp(), user: user)
        
        guard let notificationData = try? Firestore.Encoder().encode(notification) else {
            print("error encoding notification")
            return
        }
        
        currentUserRef.setData(notificationData)
    }
    
    // RETREVING THE NOTIFICATIONS FROM FIRESTORE
    static func fetchNotification(uid: String) async throws -> [Notification_ForNow] {
      
        let notisRef = FirestoreConstants.NotificationCollection.order(by: "timestamp", descending: true)
      
        let snapshot = try await notisRef.whereField("toId", isEqualTo: uid).getDocuments()
        
       return try snapshot.documents.compactMap({try? $0.data(as: Notification_ForNow.self)})
        
        //return notifications
    }
}


