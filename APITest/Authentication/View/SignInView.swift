//
//  SignInView.swift
//  APITest
//
//  Created by Benjamin  Ramos on 10/17/23.
//

import SwiftUI
import GoogleSignInSwift
import FirebaseAuth


struct SignInView: View {
    @StateObject var VM = SignInVM()
    @State private var isAlertShowing = false
    @State private var isAlertShowingGoogle = false
    var body: some View {
        NavigationStack{
            VStack {
              
                Spacer()
                VStack(spacing: 16){
                    TextField( "Enter Email", text: $VM.email)
                        .padding(12)
                        .background(Color.gray.opacity(0.16))
                        .cornerRadius(10)
                        
                    
                    SecureField("Enter Your Password", text: $VM.password)
                        .padding(12)
                        .background(Color.gray.opacity(0.16))
                        .cornerRadius(10)
                }
                .padding()
            .navigationTitle("Login")
                
                // NORMAL SIGN IN BUTTON
                Button {
                    Task { try await VM.signIn()
    if AuthenticationManager.shared.currentUser == nil {
                isAlertShowing.toggle()}
                    }
                } label: {
                    Text("Sign In")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 360, height: 44)
                        .background(Color.green)
                        .cornerRadius(8)
                       
                }
                .alert( isPresented: $isAlertShowing, content: {
                        Alert(title: Text("Invalid username or password"))
                    })
                
                
                // GOOGLE SIGN IN BUTTON, change the func in the VM
                GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
                    Task {
                        do{
                            try await VM.signInGoogleForLogin()
                                            
                        } catch{
                            if AuthenticationManager.shared.currentUser == nil {
                                        isAlertShowingGoogle.toggle()}
                            print(error.localizedDescription)
                        }
                    }
                }
                .padding()
                .alert( isPresented: $isAlertShowingGoogle, content: {
                        Alert(title: Text("You have not created an account with this email before"))
                    })
                 
                    
                    // DIVIDER ICON
                    HStack {
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width / 2 - 40, height: 0.5)
                            .foregroundColor(.gray)
                        
                        Text("OR")
                            .font(.footnote)
                            .fontWeight(.semibold)
                    
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width / 2 - 40, height: 0.5)
                            
                        
                    }
                    .foregroundColor(.gray)
                    .padding(.vertical)
                        
                    
                    Spacer()
                        Divider()
                
                // DON'T HAVE AN ACCOUNT BUTTON
                    NavigationLink {
                        AddEmailView()
                    } label: {
                        HStack{
                            Text("Don't have an account yet?")
                            Text("Sign Up!")
                        }
                    }
                    .padding(.vertical, 16)
                
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
