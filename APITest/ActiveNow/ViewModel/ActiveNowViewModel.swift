//
//  ActiveNowViewModel.swift
//  APITest
//
//  Created by Benjamin  Ramos on 12/21/23.
//

import Foundation
import FirebaseAuth

class ActiveNowViewModel: ObservableObject {
    @Published var users = [User_fornow]()
    
    init(){
        Task { try await fetchAllUsers()}
    }
    
    @MainActor
    func fetchAllUsers() async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        let users = try await UserService.fetchAllUsers(limit: 10)
        self.users = users.filter({$0.id != currentUid})
    }
}
