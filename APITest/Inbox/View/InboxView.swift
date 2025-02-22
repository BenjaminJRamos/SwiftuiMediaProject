//
//  InboxView.swift
//  APITest
//
//  Created by Benjamin  Ramos on 12/13/23.
//

import SwiftUI

struct InboxView: View {
    @State private var selectedUser: User_fornow?

    @State private var showNewMessageView = false
    @State private var showChat = false
    @StateObject var viewModel = InboxViewModel()
    @StateObject var VM = InboxService()
    
    @State var user: User_fornow
       
 
    var body: some View {
        NavigationStack{
                
                
                // CHAT INBOX
                List {
                    IsActiveNowView()
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                        .padding(.vertical)
                        .padding(.horizontal, 4)
                    
                    // THESE ARE THE RECENT MESSAGES, ADD THE ONAPPEAR HERE
                    ForEach(viewModel.recentMessages) { message in
                        ZStack{
                            NavigationLink(value: message) {
                                EmptyView()
                            }
                            .opacity(0.0)
                            InboxRowView(message: message)
                        }
                    }
                }
                .navigationTitle("Chats")
                .navigationBarTitleDisplayMode(.inline)
                .listStyle(PlainListStyle())
                .frame(height: UIScreen.main.bounds.height - 120)
                .onAppear{
                    viewModel.addListenerForRecentMessages2()
                }
            
            // NEW CHATS BUTTON COVER + LOGIC
            .onChange(of: selectedUser, perform: { newValue in
                showChat = newValue != nil
            })
            
            .navigationDestination(for: Message_ForNow.self, destination: { message in
                if let user = message.user
                {
                    ChatView(user: user)
                }
            })
            .navigationDestination(isPresented: $showChat) {
                if let user = selectedUser {
                    ChatView(user: user)
                }
            }
            // HERE IS AN OPTION TO ADD A WAY TO ACESS PORTFOLIO AND OR CHAT HERE JUST ADD ANOTHER CASE
            .navigationDestination(for: Route.self, destination: { route in
                switch route {
                case .chatView(let user):
                    ChatView(user: user)
                }
            })
            .fullScreenCover(isPresented: $showNewMessageView) {
                NewMessageView(selectedUser: $selectedUser)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack{
                        CircularProfileImageView(user: user, size: .xSmall)
                        
                        Text("Chats")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                }
                // NEW MESSGAE BUTTON
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showNewMessageView.toggle()
                        selectedUser = nil
                    } label: {
                        Image(systemName: "square.and.pencil.circle.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundStyle(.black, Color(.systemGray5))
                    }
                }
            }
        }
    }
}

struct InboxView_Previews: PreviewProvider {
    static var previews: some View {
        InboxView(user: User_fornow.Mock_USERS[1])
    }
}
