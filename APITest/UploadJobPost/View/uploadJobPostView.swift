 //
//  ContentView.swift
//  APITest
//
//  Created by Benjamin  Ramos on 9/23/23.
//

import SwiftUI
import FirebaseStorage
import PhotosUI

struct uploadJobPostView: View {
    
    @StateObject private var viewModel = uploadJobPostviewModel()
    @State private var caption = ""
    @State private var payment: String = "1"
    
    var body: some View {
        
        NavigationStack {
            VStack {
                
            
                HStack {
                    // CANCEL BUTTON
                    Button {
                        viewModel.imageSelections = []
                        caption = ""
                    } label: {
                         Text("Cancel")
                }
                    .padding()
                    Spacer()
                    
                        // UPLOAD BUTTON TO STORAGE
                    Button {
                        Task {
                            try await viewModel.uploadPost(caption: caption, payment: payment)
                            viewModel.imageSelections = []
                            caption = ""
                        }
                    
                    } label: {
                        Image(systemName: "plus.square")
                        Text("Upload")
                    }
                    .padding()
                }
                
                Spacer()
                
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
                          
                       Text("\(Image(systemName: "plus")) Add Photos of Your Lawn ")
                           .frame(width: 250, height: 50)
                           .background(Color.green)
                           .foregroundColor(Color.white)
                           .cornerRadius(16)
                    }
                   .padding()
                
                // PAYMENT SECTION
                HStack(spacing: .zero) {
                    Text("Select your Job's payment price: $")
                        .padding()
                    Picker(selection: $payment,  label: Text("Price: $")) {
                        ForEach(1..<201){ number in
                            Text("\(number)")
                            
                                .foregroundColor(Color.green)
                                .tag("\(number)")
                            
                        }
                        
                    }
                    .pickerStyle(WheelPickerStyle())
                    
                }
                Text("Final Price: $\( payment)")
                
                
                
                TextField(" Enter instructions for your job...", text: $caption, axis: .vertical)
                    .frame(width: 375, height: 210)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(12)
                    .padding()
                
                }
            .navigationTitle("Upload a Job Posting")
        }
    }
}
// LOGIC FOR PICKER
extension uploadJobPostView {
    
}


struct AddPortfolio_Previews: PreviewProvider {
    static var previews: some View {
            uploadJobPostView()
    }
}





 
                          


