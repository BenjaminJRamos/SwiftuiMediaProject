//
//  FeedCell.swift
//  APITest
//
//  Created by Benjamin  Ramos on 10/7/23.
//

import SwiftUI
import Kingfisher

struct FeedCell: View {
    let post: Post
    let user: User_fornow
    
    @State private var showSheet: Bool = false
    
    var body: some View {
        VStack{
            
            // IMAGE + USERNAME
                HStack{
                    if let user = post.user {
                        CircularProfileImageView(user: user, size: .xSmall)
                        
                        Text(user.username ?? user.fullname ?? "user")
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                    
                    Spacer()
                }
                .padding(.leading, 8)
            
     
            // POST IMAGES
            TabView{
                ForEach(Array(post.imageUrl), id: \.self){
                    images in
                    KFImage(URL(string: images))
                        .resizable()
                        .scaledToFill()
                        .frame(height: 400)
                        .clipShape(Rectangle())
                }
            }
            .frame(height: 400)
            .tabViewStyle(PageTabViewStyle())
            .sheet(isPresented: $showSheet) {
                ApplicationSheetView(post: post, user: user)
                    .presentationDetents([.medium, .large])
            }
            
            // ACTION BUTTONS
            HStack(spacing: 16) {
                Button{
                    showSheet.toggle()
                } label: {
                    Image(systemName: "heart")
                        .imageScale(.large)
                }
                
                Button{
                    print("Comment post")
                } label: {
                    Image(systemName: "bubble.right")
                        .imageScale(.large)
                }
                
                Button{
                    print("Share post")
                } label: {
                    Image(systemName: "paperplane")
                        .imageScale(.large)
                }
                
                Spacer()
            }
            .padding(.leading, 8)
            .padding(.top, 4)
            .foregroundColor(.black)
      
            
            // CAPTION LABLE
            
            HStack{
                Text("\(post.user?.username ?? "")").fontWeight(.semibold) +
                Text(post.caption)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.footnote)
            .padding(.leading, 10)
            .padding(.top, 1)
            
            HStack {
                Text("This Job Pays:") .fontWeight(.semibold) +
            Text(" $\(post.Payment)")
                
        }
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.footnote)
            .padding(.leading, 10)
          
            
            
           // TIMESTAMP
            Text(post.timeStampString)
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 10)
                .padding(.top, 1)
                .foregroundColor(.gray)
            
        }
    }
}

struct FeedCell_Previews: PreviewProvider {
    static var previews: some View {
        FeedCell(post: .MOCK_POSTS[1], user: User_fornow.Mock_USERS[1])
    }
}







