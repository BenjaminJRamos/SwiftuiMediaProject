//
//  UploadJobPostView.swift
//  APITest
//
//  Created by Benjamin  Ramos on 11/21/23.
//

import SwiftUI
import PhotosUI
import Firebase
 

struct AddPortfolioView: View {
    @StateObject var viewModel: AddPortfolioViewModel
    @Environment(\.dismiss) var dismiss
    
    init(user: User_fornow) {
        self._viewModel = StateObject(wrappedValue: AddPortfolioViewModel(user: user))
    }
    var body: some View {
        VStack{
          
            HStack {
                
                //CANCEL BUTTON
                
                Button {
                    dismiss()
                } label: {
                    Text("cancel")
                }

                
                Spacer()
                
                Button {
                    Task {
                        try await viewModel.updateUserData()
                        try await viewModel.uploadPortfolio()
                        viewModel.imageSelections = []
                        dismiss()
                    }
                   
                } label: {
                    Text ("Done")
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
            }
            .padding(.horizontal)
          
            
          
            
            
            // edit CIRCULAR IMAGE PORFILE
            
            PhotosPicker(selection: $viewModel.selectedImage1) {
                VStack{
                    if let image = viewModel.profileImage{
                        image
                            .resizable()
                            .foregroundColor(.white)
                            .background(.gray)
                            .clipShape(Circle())
                            .frame(width: 80, height: 80)
                    } else {
                        CircularProfileImageView(user: viewModel.user, size: .large)
                    }
                    
                    Text("Edit profile picture")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Divider()
                }
            }
            .padding(.vertical, 8)
            
            VStack {
                EditProfileRowView(title: "Name", placeholder: "Enter your name..", text: $viewModel.fullname)
                // ADD: $viewModel.user.fullname
                
                EditProfileRowView(title: "Bio", placeholder: "Enter your bio..", text: $viewModel.bio)
                //ADD: $viewModel.user.bio
            }
            .padding()
            .onAppear{
                viewModel.addListenerForBioAndName()
            }
            
            // UNDER HERE ADD AN UPLOAD PHOTOS BUTTON. ALSO ADD A SEPERATE FIRESTORE COLLECTION
            if !viewModel.selectedImages.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.selectedImages, id: \.self ) { image in
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            
            PhotosPicker(selection: $viewModel.imageSelections, matching: .images) {
              //  Image(systemName: "square.and.arrow.up")
                Image(systemName: "plus.square")
                Text("Add Photos of Your Previous Work ")
            }
        
  
            Spacer()
            
        }
        .navigationTitle("Edit Your Portfolio")
    }
}

struct AddPortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            AddPortfolioView(user: User_fornow.Mock_USERS[0])
        }
    }
}
