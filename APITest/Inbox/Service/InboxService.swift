//
//  InboxService.swift
//  APITest
//
//  Created by Benjamin  Ramos on 12/19/23.
//

import Foundation
import Firebase


 class InboxService: ObservableObject {
    @Published var documentChanges = [DocumentChange]()

         func observeRecentMessages() {
         guard let uid = Auth.auth().currentUser?.uid else {return}
         
         let query = FirestoreConstants.MessagesCollection.document(uid).collection("recent-messages").order(by: "timestamp", descending: true)
         
         query.addSnapshotListener { snapshot, _ in
             guard let changes = snapshot?.documentChanges.filter({
                 $0.type == .added || $0.type == .modified
             }) else {return}
             
             self.documentChanges = changes
         }
     }
}
