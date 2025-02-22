//
//  PostFunctionVM.swift
//  APITest
//
//  Created by Benjamin  Ramos on 10/6/23.
//

import Foundation
import PhotosUI
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift


@MainActor
final class uploadJobPostviewModel: ObservableObject {
  

    @Published private(set) var selectedImages: [UIImage] = []
    @Published var imageSelections: [PhotosPickerItem] = [] {
        didSet {
            Task{ await setImage(from: imageSelections)}
        }
    }
    
   
    private var uiImage: [UIImage]?
    
    private func setImage(from selections: [PhotosPickerItem]) async {
        
        Task {
            var images: [UIImage] = []
            for selection in selections {
                if let data = try? await selection.loadTransferable(type: Data.self) {
                     if let uiImage = UIImage(data: data) {
                         images.append(uiImage)
                         self.uiImage = images
                     }
                 }
            }
            selectedImages = images
            
        }
    }

   
    func uploadPost(caption: String, payment: String) async throws {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let uiImage = uiImage else { return }
        
        let postRef = Firestore.firestore().collection("posts").document()
        guard let imageUrl = try await imageUploader.UploadImages(image: uiImage) else { return }
        let post = Post(id: postRef.documentID, ownerUid: uid, caption: caption, likes: 0, imageUrl: imageUrl, timestamp: Timestamp(), Payment: payment)
        guard let encodedPost = try? Firestore.Encoder().encode(post) else { return }
        
        
        
        try await postRef.setData(encodedPost)
    }
}



