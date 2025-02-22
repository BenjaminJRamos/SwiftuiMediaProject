//
//  ChatViewModel.swift
//  APITest
//
//  Created by Benjamin  Ramos on 12/19/23.
//

import Foundation

class ChatViewModel: ObservableObject {
    @Published var messageText = ""
    @Published var messages = [Message_ForNow]()
    
    var service: ChatService
    
    init(user: User_fornow) {
        self.service = ChatService(chatPartner: user)
        observeMessages()
    }
    
    // MESSAGE LISTENER
    func observeMessages() {
        service.observeMessages() { message in
            self.messages.append(contentsOf: message)
        }
    }
    
    // SENDING MESSAGE VIEWMODEL LOGIC
    func sendMessage() {
        service.sendMessage(messageText)
    }
}
