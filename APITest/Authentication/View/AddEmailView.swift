//
//  AddEmailView.swift
//  APITest
//
//  Created by Benjamin  Ramos on 10/17/23.
//

import SwiftUI
import GoogleSignInSwift

struct AddEmailView: View {
    @State private var isAlertShowing = false
    @State private var onCondition = true
    @StateObject var viewModel = SignInVM()
    @EnvironmentObject var VM: RegistrationViewModel
    var body: some View {
        
        NavigationStack {
            
            VStack {
            
                VStack {
                    TextField("Enter your email", text: $VM.email)
                        .padding(12)
                        .background(Color.gray.opacity(0.16))
                        .cornerRadius(10)
                        .onSubmit {
                            self.getTheAlertScreen()
                        }
                }
                .padding()
                .navigationTitle("Add your email")
                
                // GOOGLE CREATE USER BUTTON
                GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
                    Task {
                        do{
                            try await viewModel.signInGoogle()
                        } catch{
                            print(error.localizedDescription)
                        }
                    }
                }
                .padding()
                
            // CONTINUE BUTTON AND LOGIC
                NavigationLink {
                    CreateYourPassword()
                    
                } label: {
                    Text("Next")
                }
                .disabled(onCondition)
                .alert( isPresented: $isAlertShowing) {
                    Alert(title: Text("Add an email"))
                }
            }
        }
    }
    
   func getTheAlertScreen() {
       if VM.email == "" {
           isAlertShowing.toggle()
           onCondition = true
       } else {
           onCondition.toggle()
       }
   }
}

struct AddEmailView_Previews: PreviewProvider {
    static var previews: some View {
        AddEmailView()
    }
}
