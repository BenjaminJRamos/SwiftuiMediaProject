//
//  InboxViewModel.swift
//  APITest
//
//  Created by Benjamin  Ramos on 12/16/23.
//

import Foundation
import SwiftUI
import Combine
import Firebase
import FirebaseFirestoreSwift
import FirebaseAuth

class InboxViewModel: ObservableObject {
    
    @Published var currentUser: User_fornow?
    @Published var recentMessages = [Message_ForNow]()
    @Published var recentMessage = [Message_ForNow]()
    
    
    private var cancellables = Set<AnyCancellable>()
    private let service2 = InboxService()
    private let service3 = RecentMessageService()
    
    
    @MainActor
    init() {
        //      setUpSubscribersForInbox()
        //    service2.observeRecentMessages()
        //     addListenerForRecentMesssagesTest2()
    }
    
    // FETCHING THE RECENT MESSAGE
    @MainActor
    func setUpSubscribersForInbox() {
        
        UserServiceForMessenger.shared.$currentUser.sink{ completion in
            //  self?.currentUser = user
        } receiveValue: { [weak self] user in
            self?.currentUser = user
        }
        
        .store(in: &cancellables)
        
        service2.$documentChanges.sink { completion in
            
        }
    receiveValue: { [weak self] changes in
        self?.loadInitialMessages(fromChanges: changes)
    }
    .store(in: &cancellables)
    }
    
    // LISTENER TEST 2 FOR RECENT MESSAGES
    @MainActor
    func addListenerForRecentMessages2() {
        service3.listenForRecentMessagesTest2 { messages in
            self.recentMessages = messages
        }
    }
    
    
    // FETCHING MESSAGES
    
    private func loadInitialMessages(fromChanges changes: [DocumentChange] ) {
        var messages = changes.compactMap({ try? $0.document.data(as: Message_ForNow.self)})
        
        for i in 0 ..< messages.count {
            let message = messages[i]
            
            UserServiceForMessenger.fetchUserCombine(withUid: message.ChatPartnerId) { user in
                messages[i].user = user
                
                DispatchQueue.main.async {
                    self.recentMessages.append(messages[i])
                }
            }
        }
    }
}


