//
//  Create your password.swift
//  APITest
//
//  Created by Benjamin  Ramos on 10/17/23.
//

import SwiftUI

struct CreateYourPassword: View {
    @State private var isAlertShowing = false
    @State private var onCondition = true
    @EnvironmentObject var VM: RegistrationViewModel
    
    var body: some View {
        NavigationStack{
            VStack{
            VStack{
                SecureField("Enter your password", text: $VM.password)
                    .padding(12)
                    .background(Color.gray.opacity(0.16))
                    .cornerRadius(10)
                    .onSubmit {
                        self.getTheAlertScreen()
                    }
            }
            .padding()
            .navigationTitle("Add your password")
                
                NavigationLink {
                    CreateUsernameView()
                } label: {
                    Text("Next")
                }
                .disabled(onCondition)
                .alert( isPresented: $isAlertShowing) {
                    Alert(title: Text("Add a Password"))
                }
            
            }
        }
    }
    
    func getTheAlertScreen() {
        if VM.password == "" {
            isAlertShowing.toggle()
            onCondition = true
        } else {
            onCondition.toggle()
        }
    }
}

struct Create_your_password_Previews: PreviewProvider {
    static var previews: some View {
        CreateYourPassword()
    }
}
