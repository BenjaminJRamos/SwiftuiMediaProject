//
//  NewMessageView.swift
//  APITest
//
//  Created by Benjamin  Ramos on 12/17/23.
//

import SwiftUI

struct NewMessageView: View {
    @State private var searchText = ""
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = NewMessageViewModel()
    @Binding var selectedUser: User_fornow?
    
    var body: some View {
        NavigationStack {
            ScrollView{
                TextField("To:", text: $searchText)
                    .frame(height: 44)
                    .padding(.leading)
                    .background(Color(.systemGroupedBackground))
                
                //CONTACTS
                Text("Contacts")
                    .foregroundColor(Color(.systemGray4))
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
// CONTACT PROFILE IMAGES, YOU WILL REPLACE THIS AT SOME TIME TO A CONTACTS COLLECTIONS IN FIRESTORE OR SOMETHING SIMULAR
                ForEach(viewModel.users) { user in
                  
                    
                    VStack {
                        HStack {
                            CircularProfileImageView(user: user, size: .medium)
                            
                            Text(user.username ?? user.fullname ?? "")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            
                            Spacer()
                        }
                        .padding(.leading)
                        
                        Divider()
                        .padding(.leading, 40)
                    }
                    .onTapGesture {
                        selectedUser = user
                        dismiss()
                    }
                }
            }
            .navigationTitle("New Message")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.black)
                }
        }
        }
    }
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        NewMessageView(selectedUser: .constant(User_fornow.Mock_USERS[1]))
    }
}
