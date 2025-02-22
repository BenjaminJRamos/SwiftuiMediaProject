//
//  AuthenticationManager.swift
//  APITest
//
//  Created by Benjamin  Ramos on 10/18/23.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore


 class AuthenticationManager {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User_fornow?
    
    
     static let shared = AuthenticationManager()
    
     init() { Task{ try await getUserInfo()} }
    
    // MAKING A NEW USER FUNCTION
    @MainActor
    func createUser(email: String, password: String, username: String) async throws {
        
        do {
            let result =  try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            await self.SendUserInfo(uid: result.user.uid, username: username, email: email)
        } catch {
            print("error registering user, \(error.localizedDescription)")
        }
    }
    // LOGING IN EXiSTING USER
    @MainActor
    func login(withEmail email: String, withPassword password: String) async throws {
        
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            try await getUserInfo()
        } catch {
            print("error loging in \(error.localizedDescription)")
        }
    }
     @MainActor
     func signOut() {
         try? Auth.auth().signOut()
         self.userSession = nil
         self.currentUser = nil
     }
     
     func resetPassword(email: String) async throws {
         try await Auth.auth().sendPasswordReset(withEmail: email)
         
     }
     
     func GetAuthenticatedUser() throws -> AuthdataResultModel {
         guard let user = Auth.auth().currentUser else {
             throw URLError(.badURL)
         }
         return AuthdataResultModel(user: user)
     }
    
    private func SendUserInfo(uid: String, username: String, email: String) async {
        let user = User_fornow(id: uid, username: username, email: email)
        self.currentUser = user
        guard let encoderUser = try? Firestore.Encoder().encode(user) else { return }
        try? await Firestore.firestore().collection("users").document(user.id).setData(encoderUser)
    }
     
   
    
  private func getUserInfo() async throws {
        self.userSession = Auth.auth().currentUser
        guard let CurrentUid = userSession?.uid else {return}
        self.currentUser = try await UserService.fetchUser(withUid: CurrentUid)
    }
}

// Sign IN WITH GOOGLE LOGIC
extension AuthenticationManager {
    
    @discardableResult
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthdataResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
       
        return try await signIn(credential: credential)

    }
    @MainActor
    func signIn(credential: AuthCredential) async throws -> AuthdataResultModel {
        let authDataResult = try await Auth.auth().signIn(with: credential)
        self.userSession = authDataResult.user
        await self.SendUserInfoGoogle(uid: authDataResult.user.uid, email: authDataResult.user.email, username: authDataResult.user.email)
        
        return AuthdataResultModel(user: authDataResult.user)
    }
    
    private func SendUserInfoGoogle(uid: String, email: String?, username: String?) async {
        let user = User_fornow(id: uid, username: username, email: email)
        self.currentUser = user
        guard let encoderUser = try? Firestore.Encoder().encode(user) else { return }
        try? await Firestore.firestore().collection("users").document(user.id).setData(encoderUser)
    }
     
    // JUST THE LOGIN PORTION OF GOOGLE SIGN IN
    
     
        @discardableResult
    func signInWithGoogleToLogin(tokens: GoogleSignInResultModel) async throws -> (AuthdataResultModel?) {
            let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
           
//  LEFT OFF, USE THE BOOL VALUE TO SIGN IN THE USER 
            return try await (signInToLogin(credential: credential)
            )
        }
        @MainActor
    func signInToLogin(credential: AuthCredential) async throws -> AuthdataResultModel? {
   
                let authDataResult = try await Auth.auth().signIn(with: credential)
             //   SWITCH LOGIC
 
        let FirestoreReadableUidString = try await Firestore.firestore().collection("users").document(authDataResult.user.uid).getDocument().data(as: User_fornow.self)
        
        if authDataResult.user.uid == FirestoreReadableUidString.id {
            
                    self.userSession = authDataResult.user
                    await self.SendUserInfoGoogleToLogin(uid: authDataResult.user.uid, email: authDataResult.user.email, username: authDataResult.user.email)
                    return AuthdataResultModel(user: authDataResult.user)
                } else {
                    self.currentUser = nil
                    return nil
            }
        }
  
    private func SendUserInfoGoogleToLogin(uid: String, email: String?, username: String?) async {
        let user = User_fornow(id: uid, username: username, email: email)
        self.currentUser = user
        }
    }


extension AuthenticationManager {
    // LISTENER TO UPDATE FEED IN REAL TIME
    func addListenerToUploadImages(completion: @escaping (_ products: [Post]) -> Void) {
        
        let postRef = Firestore.firestore().collection("posts").order(by: "timestamp", descending: true)
        
        postRef.addSnapshotListener { querySnapshot, error in
            guard let document = querySnapshot?.documents else {
                print("No documents")
                return
            }
            var products: [Post] = document.compactMap({ try? $0.data(as: Post.self)})
            
            var productsArrayForPost: [Post] = []
            
            for i in 0 ..< products.count {
                let post = products[i]
                let ownerUid = post.ownerUid
                UserServiceForMessenger.fetchUserCombine(withUid: ownerUid) { user in
                    products[i].user = user
                    productsArrayForPost.append(products[i])
                    completion(productsArrayForPost)
                }
            }
        }
    }
    
    // LISTENER FOR PORTFOLIO
    func addListenerToPortfolio(completion: @escaping (_ products: [Portfolio]) -> Void) {
        
        let postRef = Firestore.firestore().collection("portfolio").order(by: "times", descending: true)
        postRef.addSnapshotListener { querySnapshot, error in
            guard let document = querySnapshot?.documents else {
                print("No documents")
                return
            }
            let products: [Portfolio] = document.compactMap({ try? $0.data(as: Portfolio.self)})
            completion(products)
        }
    }
    
    // LISTENER FOR USERS
    func addListenerToBioAndNameTest(completion: @escaping(_ userData: User_fornow) -> Void) {
        
        let TheCurrentUser = self.currentUser?.id ?? ""
        let postRef = Firestore.firestore().collection("users")
        postRef.document("\(TheCurrentUser)").addSnapshotListener {
            
                documentSnapshot, error in
            guard let document = documentSnapshot else {
                    print("error fecthing document")
                    return
                }
            
                guard let userData = try? document.data(as: User_fornow.self)
               
                else {
                    print("error")
                    return
                }
                completion(userData)
            }
        }
    // LISTENER
    
    func listenForNotifications(completion: @escaping ( [Notification_ForNow]) -> Void) {

        let notiRef = FirestoreConstants.NotificationCollection.order(by: "timestamp", descending: true)
        
        notiRef.addSnapshotListener { QuerySnapshot, error in
            guard let document = QuerySnapshot?.documents
            else {
                print("no documents")
                return
            }
            let products: [Notification_ForNow] =
            
            document.compactMap({ try? $0.data(as: Notification_ForNow.self)})
            
            completion(products)
        }
    }
}

   



