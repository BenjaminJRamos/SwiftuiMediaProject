//
//  RecentMessageService.swift
//  APITest
//
//  Created by Benjamin  Ramos on 1/1/24.
//

import Foundation
import Firebase

class RecentMessageService: ObservableObject {
    
    // LISTENER FOR RECENT MESSAGES
    @MainActor
    func listenForRecentMessages(completion: @escaping ([Message_ForNow]) -> Void) {

        guard let currentUid = Auth.auth().currentUser?.uid else {return}
     
        let messageRef = FirestoreConstants.MessagesCollection.document(currentUid).collection("recent-messages").order(by: "timestamp", descending: true)
            
        
        messageRef.addSnapshotListener { querySnapshot, _ in
            guard let document = querySnapshot?.documentChanges.filter({$0.type == .added || $0.type == .modified})
            else {
               print("no documents")
               return
           }
            let products = document.compactMap({try? $0.document.data(as: Message_ForNow.self)})
          
        completion(products)
            
        }
    }
    
    // TEST LISTENER
    @MainActor
    func listenForRecentMessagesTest2(completion: @escaping ([Message_ForNow]) -> Void) {

        guard let currentUid = Auth.auth().currentUser?.uid else {return}
     
        let messageRef = FirestoreConstants.MessagesCollection.document(currentUid).collection("recent-messages").order(by: "timestamp", descending: true)
            
        
        messageRef.addSnapshotListener { querySnapshot, _ in
            guard let document = querySnapshot?.documentChanges.filter({$0.type == .added || $0.type == .modified})
            else {
               print("no documents")
               return
           }
            var products = document.compactMap({try? $0.document.data(as: Message_ForNow.self)})
            
            var productsArray: [Message_ForNow] = []
            
            for i in 0 ..< products.count {
                let product = products[i]
              
                UserServiceForMessenger.fetchUserCombine(withUid: product.ChatPartnerId) { user in
                    products[i].user = user
                    productsArray.append(products[i])
                    completion(productsArray)
                }
            }
        }
    }
}
