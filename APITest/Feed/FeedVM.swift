//
//  FeedVM.swift
//  APITest
//
//  Created by Benjamin  Ramos on 10/7/23.
//

import Foundation
import Firebase

class FeedViewModel: ObservableObject {
    @Published var posts = [Post]()
    
    init(){
        Task { try await fetchPosts() }
        }
        
    // LISTENER
    func addListenerForPosts(){
        AuthenticationManager.shared.addListenerToUploadImages { [weak self] products in
            self?.posts = products
        }
    }
    
    // FETCH POST FUNCTION
        @MainActor
        func fetchPosts() async throws {
            self.posts = try await PostService.fetchFeedPosts()
        }
    }


