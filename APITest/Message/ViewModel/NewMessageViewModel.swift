//
//  NewMessageViewModel.swift
//  APITest
//
//  Created by Benjamin  Ramos on 12/17/23.
//

import Foundation
import FirebaseAuth

class NewMessageViewModel: ObservableObject {
    @Published var users = [User_fornow]()
    
    init() {
        Task { try await fetchAllUsers() }
        }
        
    @MainActor
        func fetchAllUsers() async throws {
            guard let currentUid = Auth.auth().currentUser?.uid else {return}
            let users = try await UserService.fetchAllUsers()
            self.users = users.filter({$0.id != currentUid})
    }
}
