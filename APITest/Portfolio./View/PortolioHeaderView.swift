//
//  PortolioHeaderView.swift
//  APITest
//
//  Created by Benjamin  Ramos on 11/25/23.
//

import SwiftUI

struct PortolioHeaderView: View {
    var user: User_fornow
    @StateObject var viewModel: AddPortfolioViewModel
    init(user:User_fornow) {
        self._viewModel = StateObject(wrappedValue: AddPortfolioViewModel(user: user))
        self.user = user
    }
    
    
    
    @State private var showEditProfile = false
 
    var body: some View {
        VStack(spacing: 10) {
            
            
            // PIC AND STATS
            HStack{
                CircularProfileImageView(user: viewModel.user, size: .large)
                
                Spacer()
                
                HStack(spacing: 8) {
                      UserStatView(value: 0, title: "Posts")
                     
                    UserStatView(value: 0, title: "Followers")
                        
                    VStack{
                        Text("0")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Text("Jobs Completed")
                            .font(.footnote)
                    }
                    .frame(width: 100)
                }
            }
            .padding(.horizontal)
         
            
            // NAME AND BIO
            VStack(alignment:.leading, spacing: 4) {
                if let fullname = viewModel.user.fullname {
                    Text(fullname)
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                    
                if let bio = viewModel.user.bio {
                        Text(bio)
                            .font(.footnote)
                    }
                }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .onAppear{
                viewModel.addListenerForBioAndName()
            }
           
          
            
        //  ACTION BUTTON
            Button {
                if user.isCurrentUser {
                    showEditProfile.toggle()
                } else {
                    print("Follow user..")
                }
                
            }label: {
                Text(user.isCurrentUser ? "Edit Profile" : "Follow")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 360, height:32)
                    .background(user.isCurrentUser ? .white : Color(.systemGreen))
                    .foregroundColor(user.isCurrentUser ? .black : .white)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(user.isCurrentUser ? .gray : .clear, lineWidth: 1)
                    )
            }
            Divider()
        }
        .fullScreenCover(isPresented: $showEditProfile) {
            AddPortfolioView(user: user)
        }
    }
}

struct PortolioHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        PortolioHeaderView(user: User_fornow.Mock_USERS[0])
    }
}
