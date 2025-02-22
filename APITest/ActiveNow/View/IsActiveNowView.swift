//
//  IsActiveNowView.swift
//  APITest
//
//  Created by Benjamin  Ramos on 12/13/23.
//

import SwiftUI

struct IsActiveNowView: View {
    @StateObject var viewModel = ActiveNowViewModel()
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 32) {
                ForEach(viewModel.users) { user in
                    NavigationLink(value: Route.chatView(user) ) {
                        VStack{
                            ZStack(alignment: .bottomTrailing){
                                // USER PROFILE PICS
                                CircularProfileImageView(user: user, size: .small)
                                
                               // IS ACTIVE CIRCLE
                                ZStack {
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 18, height: 18)
                                    
                                    Circle()
                                        .fill(Color(.systemGreen))
                                        .frame(width: 12, height: 12)

                                    
                                }
                            }
                            // USERNAME
                            Text(user.username ?? user.fullname ?? "")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                        }
                    }
                }
            }
            .padding()
        }
        .frame(height: 106)
    }
}

struct IsActiveNowView_Previews: PreviewProvider {
    static var previews: some View {
        IsActiveNowView()
    }
}
