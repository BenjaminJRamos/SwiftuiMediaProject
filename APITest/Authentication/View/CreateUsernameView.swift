//
//  CreateUsernameView.swift
//  APITest
//
//  Created by Benjamin  Ramos on 10/18/23.
//

import SwiftUI

struct CreateUsernameView: View {
    @State private var isAlertShowing = false
    @State private var onCondition = true
    @EnvironmentObject var VM: RegistrationViewModel
    var body: some View {
        NavigationStack{
            VStack{
            VStack{
                TextField("Create a username", text: $VM.username)
                    .padding(12)
                    .background(Color.gray.opacity(0.16))
                    .cornerRadius(10)
                    .onSubmit {
                        self.getTheAlertScreen()
                    }
            }
            .padding()
            .navigationTitle("Create a username!")
                
                NavigationLink {
                    GoToTheHomePage()
                } label: {
                    Text("Next")
                }
                .disabled(onCondition)
                .alert( isPresented: $isAlertShowing) {
                    Alert(title: Text("Add a Username"))
                }
            }
        }
    }
    func getTheAlertScreen() {
        if VM.username == "" {
            isAlertShowing.toggle()
            onCondition = true
        } else {
            onCondition.toggle()
        }
    }
}

struct CreateUsernameView_Previews: PreviewProvider {
    static var previews: some View {
        CreateUsernameView()
    }
}
