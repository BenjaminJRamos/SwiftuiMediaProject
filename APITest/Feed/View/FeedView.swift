//
//  FeedView.swift
//  APITest
//
//  Created by Benjamin  Ramos on 9/29/23.
//

import SwiftUI
import Kingfisher

struct FeedView: View {
    @StateObject var VM = FeedViewModel()
    let user: User_fornow
   
    
    var body: some View {

        NavigationStack{
            ScrollView {
                LazyVStack(spacing:32) {
                    
                    Text("Posts")
                    
                    // CHECK THE USER HERE
                    ForEach(VM.posts) { post in
                        FeedCell(post: post, user: user)
                    
                    }
                }
                .padding(.top,8)
            }
        }
        .onAppear{
                VM.addListenerForPosts()
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(user: User_fornow.Mock_USERS[1])
    }
}



 
