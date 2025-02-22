//
//  FetchUserService.swift
//  APITest
//
//  Created by Benjamin  Ramos on 10/20/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct UserService {
   
    
    // GETTING A SPECIFIC USER
    static func fetchUser(withUid uid: String) async throws -> User_fornow {
        
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        return try snapshot.data(as: User_fornow.self)
    }
    
    // GETTING ALL USERS WITH AN OPTIONAL LIMIT
    static func fetchAllUsers(limit: Int? = nil) async throws -> [User_fornow] {
        let query = FirestoreConstants.UserCollection
        if let limit { query.limit(to: limit) }
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
      return snapshot.documents.compactMap({try? $0.data(as: User_fornow.self)})
      
    }
    
    // GETTING ALL USERS WITH AN OPTIONAL LIMIT
    static func fetchAllUsersForGoogle(limit: Int? = nil) async throws -> [User_fornow]? {
        let query = FirestoreConstants.UserCollection
        if let limit { query.limit(to: limit) }
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
      return snapshot.documents.compactMap({try? $0.data(as: User_fornow.self)})
      
    }
    
  
}
