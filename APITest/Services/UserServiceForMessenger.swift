//
//  UserServiceForMessenger.swift
//  APITest
//
//  Created by Benjamin  Ramos on 1/1/24.
//

import Foundation
import Combine
import SwiftUI
import Firebase

class UserServiceForMessenger {
    
    @Published var currentUser: User_fornow?
    
    static let shared = UserServiceForMessenger()
    
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        let user = try snapshot.data(as: User_fornow.self)
        self.currentUser = user
    }
    // LISTENER FOR USERS
    static func fetchUserCombine(withUid uid: String, completion: @escaping(User_fornow) -> Void) {
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User_fornow.self) else {return}
            completion(user)
        }
    }
}
