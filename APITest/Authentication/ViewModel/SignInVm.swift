//
//  SignInVm.swift
//  APITest
//
//  Created by Benjamin  Ramos on 10/17/23.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift
import FirebaseFirestore
import FirebaseFirestoreSwift

struct GoogleSignInResultModel {
    let idToken: String
    let accessToken: String
}


@MainActor
final class SignInVM: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
   
    // NORMAL SIGN IN
    func signIn() async throws {
        try await AuthenticationManager.shared.login(withEmail: email, withPassword: password)
        
    }
    
    // SIGN IN WITH GOOGLE
    func signInGoogle() async throws {
        guard let topVC = Utilities.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        guard let idToken = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        let accessToken: String = gidSignInResult.user.accessToken.tokenString
        
        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken)
        // SENDING + CHECKING AUTHEMTICATION TO FIRESTORE
        try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
    }
    
    // SIGN IN WITH GOOGLE FOR LOGIN
    // YOU CAN MAKE RUN SOMETHING AT THE TOP, MAYBE AN IF ELSE STATEMENT, THAT CHECKS IF THE USER HAS AN ACCOUNT IN FIREBASE USERS AND IF NOT THE WHOLE THING WILL THROW AN ERROR
    
     
     
    func signInGoogleForLogin() async throws {
        guard let topVC = Utilities.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        guard let idToken = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        let accessToken: String = gidSignInResult.user.accessToken.tokenString
        
        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken)
        // SENDING + CHECKING AUTHEMTICATION TO FIRESTORE
        try await AuthenticationManager.shared.signInWithGoogleToLogin(tokens: tokens)
    }
}


