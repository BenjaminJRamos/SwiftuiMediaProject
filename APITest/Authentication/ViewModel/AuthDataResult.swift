//
//  TestViewModel.swift
//  APITest
//
//  Created by Benjamin  Ramos on 10/24/23.
//

import Foundation
import FirebaseAuth
import Firebase

struct AuthdataResultModel {
    let uid: String
    let email: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
    }
}



final class TheManager {
    static let Newshared = TheManager()
    private init(){}
    
    func makeUser(email: String, password: String) async throws -> AuthdataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthdataResultModel(user: authDataResult.user)
           
        }
    }
   
// sign in google
//extension TheManager {
//
//    func signInWithGoogle(credential: AuthCredential) async throws -> AuthdataResultModel {
//        let authDataResult = try await Auth.auth().signIn(with: credential)
//        return AuthdataResultModel(user: authDataResult.user)
//    }
//
//}


