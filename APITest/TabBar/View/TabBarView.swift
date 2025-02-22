//
//  TabBarView.swift
//  APITest
//
//  Created by Benjamin  Ramos on 9/29/23.
//

import SwiftUI
import Firebase


struct TabBarView: View {
    let user: User_fornow
    @StateObject var viewModel = DecisionViewModel()
    @State var selectedpage: Int = 0
    var body: some View {
        
     
        if selectedpage == 0 {
            VStack{
                    Text("Welcome Back")
                        .font(.title)
          
                Spacer()
                Button {
                    findHelpButton()
                } label: {
                    Text("Upload a Job Posting")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 360, height: 44)
                        .background(Color.green)
                        .cornerRadius(8)
                        
                }
                
                
                Button {
                    findJobsButton()
                } label: {
                    Text("Find Jobs")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 360, height: 44)
                        .background(Color.green)
                        .cornerRadius(8)
                }
                
                Button {
                    messageButton()
                } label: {
                    Text("Look at your Messages")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 360, height: 44)
                        .background(Color.green)
                        .cornerRadius(8)
                }

                
                Button {
                    editProfileButton()
                } label: {
                    Text("Edit your Portfolio (We recomend you do this before looking for work!")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 360, height: 44)
                        .background(Color.green)
                        .cornerRadius(8)
                }
                
                // SIGN OUT BUTTON
                Button {
                    AuthenticationManager.shared.signOut()
                } label: {
                    HStack{
                        Image(systemName: "hand.wave")
                        Text("Sign out")
                    }
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 360, height: 44)
                        .background(Color.red)
                        .cornerRadius(8)
                }
                
                Spacer()
             
                
                Button {
                Task{ try await viewModel.resetThePassword()}
                } label: {
                    Text("Do you want to reset your password?")
                }
            }
        }
        
        
        
        
        TabView(selection: $selectedpage) {
            
            notificationView(user: user)
                .onAppear(){
                    selectedpage = 0
                }
                .tabItem {
                    Image(systemName: "questionmark.diamond.fill")
                }
                .tag(0)
            
            
            
            uploadJobPostView()
                .onAppear(){
                   selectedpage = 1
            }
            .tabItem {
                Image(systemName: "plus")
            }
            .tag(1)
            
            FeedView(user: user)
                .onAppear(){
                    selectedpage = 2
            }
            .tabItem {
                Image(systemName: "book")
            }
            .tag(2)
            
            InboxView(user: user)
                .onAppear(){
                    selectedpage = 3
                }
                .tabItem {
                    Image(systemName: "message.fill")
                }
                .tag(3)
            
            PortfolioView(user: user)
                .onAppear(){
                   selectedpage = 4
                }
                .tabItem{
                        Image(systemName: "person.crop.circle")
                }
                .tag(4)
        }
    }
}

// BUTTON LOGIC
extension TabBarView {
    func findHelpButton() {
        selectedpage = 1
    }
    
    func findJobsButton() {
        selectedpage = 2
    }
    
    func messageButton() {
        selectedpage = 3
    }
    
    func editProfileButton() {
        selectedpage = 4
    }
}



struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(user: User_fornow.Mock_USERS[1])
    }
}
