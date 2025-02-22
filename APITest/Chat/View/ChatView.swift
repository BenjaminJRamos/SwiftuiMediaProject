//
//  ChatView.swift
//  APITest
//
//  Created by Benjamin  Ramos on 12/17/23.
//

import SwiftUI

struct ChatView: View {
    @StateObject var viewModel: ChatViewModel
    let user: User_fornow
    init(user:  User_fornow) {
        self._viewModel = StateObject(wrappedValue: ChatViewModel(user: user))
        self.user = user
    }
    var body: some View {
        VStack {
            ScrollView{
               
                // HEADER
                // SOME DAY YOU WILL REPLACE THE TYPE user: TO A CONTACTS USER DOCUMENT IN FIRESTORE/FIREBASE
                CircularProfileImageView(user: user, size: .large)
                
                VStack(spacing: 4) {
                    Text(user.username ?? user.fullname ?? user.email ?? "")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Text("Fix My Lawn")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
 
                // MESSAGES
                LazyVStack(){
                    ForEach(viewModel.messages) { message in
                        ChatMessageCell(message: message, user: user)
                    }
                }
                
                
            }
            .defaultScrollAnchor(.bottom)
        
            // MESSGAE IMPUT VIEW
            Spacer()
            
            ZStack( alignment: .trailing) {
                TextField("Message...", text: $viewModel.messageText, axis: .vertical)
                    .padding(12)
                    .padding(.trailing, 48)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(Capsule())
                    .font(.subheadline)
                
                // SEND BUTTON
                Button {
                    viewModel.sendMessage()
                    viewModel.messageText = ""
                } label: {
                    Text("Send")
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                }
            }
            .padding()
        }
        .navigationTitle(user.fullname ?? user.email ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(user: User_fornow.Mock_USERS[1])
    }
}
