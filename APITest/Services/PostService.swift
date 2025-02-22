//
//  PostService.swift
//  APITest
//
//  Created by Benjamin  Ramos on 9/30/23.
//

import Firebase
import FirebaseFirestore

struct PostService {
    
    private static let postCollection =  Firestore.firestore().collection("posts")
    private static let portfolioCollection =  Firestore.firestore().collection("portfolio")
    
    static func fetchFeedPosts() async throws -> [Post] {
        let snapshot = try await postCollection.getDocuments()
        var posts = try snapshot.documents.compactMap({ try $0.data(as: Post.self) })
       
        for i in 0 ..< posts.count {
            let post = posts[i]
            let ownerUid = post.ownerUid
            let postUser = try await UserService.fetchUser(withUid: ownerUid)
            posts[i].user = postUser
            
          
        }
        return posts
    }
    
    
    static func fetchUserPosts(uid: String) async throws -> [Post] {
        let snapshot = try await postCollection.whereField("ownerUid", isEqualTo: uid).getDocuments()
        return try snapshot.documents.compactMap({ try $0.data(as: Post.self) })
    }
    
    
    
    
    static func fetchUserPortfolios(uid: String) async throws -> [Portfolio] {
        let snapshot = try await portfolioCollection.whereField("ownerUid", isEqualTo: uid).getDocuments()
        return try snapshot.documents.compactMap({ try $0.data(as: Portfolio.self) })
    }
}


