//
//  ApplicationSheetView.swift
//  APITest
//
//  Created by Benjamin  Ramos on 12/8/23.
//

import SwiftUI
import UserNotifications

struct ApplicationSheetView: View {
    
    @StateObject var viewModel: ApplicationViewModel
    @Environment(\.dismiss) var dismiss
    @State var badgeManager = AppAlertBadgeManager(application: UIApplication.shared)
    let post: Post
    
    init(post: Post, user: User_fornow) {
        self._viewModel = StateObject(wrappedValue: ApplicationViewModel(user: user, post: post))
        self.post = post
    }
    
    var body: some View {
        NavigationStack{
            
           // APPLICATION SCREEN COMPONENTS 
            
            VStack{
                Text("Apply for this job!")
                    .font(.title)
                    .padding()
                Spacer()
              
                HStack{
                    
                  Text("Pay: ")
                        .font(.subheadline)
                    + Text("$\(post.Payment)")
                }
                .padding(2)
                
                HStack{
                    Text("Job Description: ")
                        .font(.subheadline)
                    + Text(post.caption)
                }
                
                // APPLY BUTTON THIS SHOULD TRIGGER A NOTIFICATION, PLAN IN MIRO 
                Button {
                    print("applied")
                    viewModel.sendApplication(post: post)
                    viewModel.triggerLocalNotification()
                    viewModel.bareBoneNoti()
                    badgeManager.setAlertBadge(number: 1)
                    dismiss()
                } label: {
                    Text("Apply")
                        .frame(width: 200, height: 50 )
                        .background(Color.green)
                        .foregroundColor(Color.white)
                        .cornerRadius(16)
                }
                
                .padding(.vertical)
         
                Spacer()
            }
        }
        .navigationTitle("Apply for this job")
    }
}

struct ApplicationSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationSheetView(post: Post.MOCK_POSTS[1], user: User_fornow.Mock_USERS[1])
    }
}
