//
//  FirestoreConstants.swift
//  APITest
//
//  Created by Benjamin  Ramos on 12/19/23.
//

import Foundation
import Firebase

struct FirestoreConstants {
    static let MessagesCollection = Firestore.firestore().collection("messages")
    
    static let UserCollection = Firestore.firestore().collection("users")
    
    static let NotificationCollection = Firestore.firestore().collection("notifications")
}
