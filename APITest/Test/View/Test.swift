//
//  Test.swift
//  APITest
//
//  Created by Benjamin  Ramos on 10/24/23.
//
/*
import SwiftUI

@MainActor
final class PlugIn: ObservableObject{
    
    @Published var email = ""
    @Published var password = ""

    func signIn() {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        Task {
            
            do{
                let returnedUserData = try await TheManager.Newshared.makeUser(email: email, password: password)
                print("Success")
                print(returnedUserData)
            } catch {
                print("Error: \(error)")
            }
        }
    }
}

struct Test: View {
    @StateObject var VM = PlugIn()
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
                
                // sign in button
                Button {
                    VM.signIn()
                } label: {
                    Text("Sign In")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 360, height: 44)
                        .background(Color.green)
                        .cornerRadius(8)
                       
                }
                    
                    //divider icon
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

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}

*/
