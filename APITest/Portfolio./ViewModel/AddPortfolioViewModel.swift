//
//  AddPortfolioViewModel.swift
//  APITest
//
//  Created by Benjamin  Ramos on 11/23/23.
//

import PhotosUI
import SwiftUI
import Firebase
import FirebaseFirestore

@MainActor
class AddPortfolioViewModel: ObservableObject {
    @Published var user: User_fornow
    
    @Published var selectedImage1: PhotosPickerItem? {
        didSet { Task{await loadImage(fromItem: selectedImage1) } }
    }
    @Published var profileImage: Image?
    
    @Published var fullname: String = ""
    @Published var bio = ""
    
    private var uiImage: UIImage?
    
    
    init(user: User_fornow) {
        self.user = user
        
        Task{ try await FetchNameandBio() }
    }
    
    func FetchNameandBio() async throws {
        if let fullname = user.fullname {
           self.fullname = fullname
        }
        if let bio = user.bio{
            self.bio = bio
        }
    }
    
    // LISTENER
    func addListenerForBioAndName(){
        
        addListenerToBioAndNameTest4 { [weak self] userInfo in
            self?.user = userInfo
            self?.user.fullname = userInfo.fullname
            self?.user.bio = userInfo.bio
            self?.fullname = userInfo.fullname ?? ""
            self?.bio = userInfo.bio ?? ""
            self?.UrltoImage(urlstring: userInfo.profileImageUrl ?? "")
            Task { try await self?.FetchNameandBio() }
            
        }
    }
    
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
        
    }
    
    func updateUserData() async throws {
        // update profile image if changed, add a listener (haha thats cool that I know that now)
        
        var data = [String: Any]()
        
        if let uiImage = uiImage {
         let imageUrl = try? await imageUploader.uploadImage(image: uiImage)
            data["profileImageUrl"] = imageUrl
        }
        
        //update name if changed
        if !fullname.isEmpty  && user.fullname != fullname {
            data["fullname"] = fullname
        }
       
        //update bio if changed
        if !bio.isEmpty  && user.bio != bio {
            data["bio"] = bio
        }
        
        if !data.isEmpty {
            try await Firestore.firestore().collection("users").document(user.id).updateData(data)
        }
    }
    
    // PUBLISHING PROPERTIES FOR UPLOADING PORTFOLIOS
    @Published private(set) var selectedImages: [UIImage] = []
    @Published var imageSelections: [PhotosPickerItem] = [] {
        didSet {
            Task{ await setImage(from: imageSelections)}
        }
    }
    
   
    private var uiImages: [UIImage]?
    
    private func setImage(from selections: [PhotosPickerItem]) async {
        
        Task {
            var images: [UIImage] = []
            for selection in selections {
                if let data = try? await selection.loadTransferable(type: Data.self) {
                     if let uiImage = UIImage(data: data) {
                         images.append(uiImage)
                         self.uiImages = images
                     }
                 }
            }
            selectedImages = images
            
        }
    }
}

extension AddPortfolioViewModel {
    
    // ADDING PORTFOLIO LOGIC, THEN SEND IT TO FIREBASE UNDER A NEW COLLECTION
    func uploadPortfolio() async throws {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let uiImage = uiImages else { return }
        
        let postRef = Firestore.firestore().collection("portfolio").document()
        guard let imageUrl = try await imageUploader.UploadImages(image: uiImage) else { return }
        let portfolio = Portfolio(id: postRef.documentID, ownerUid: uid, imageUrl: imageUrl)
        guard let encodedPost = try? Firestore.Encoder().encode(portfolio) else { return }
        
        
        
        try await postRef.setData(encodedPost)
    }
    
    // LISTENER FUNCTION
 
    func addListenerToBioAndNameTest4(completion: @escaping(_ userData: User_fornow) -> Void) {
        
        let postRef = Firestore.firestore().collection("users")
        postRef.document("\(user.id)").addSnapshotListener {
            
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
    
    // CONVERTING URL TO IMAGE
    
    private func UrltoImage(urlstring: String) {
        guard let url = URL(string: urlstring) else {return}
        
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            guard error == nil else{
                print(error ?? "unknown error")
                return
            }
            guard let data = data else{
                print("no data")
                return
            }
            DispatchQueue.main.sync {
                [weak self] in
                guard let loadedImage = UIImage(data: data) else {return}
                self?.profileImage = Image(uiImage: loadedImage)
                
                
                }
            }
        }
    }


