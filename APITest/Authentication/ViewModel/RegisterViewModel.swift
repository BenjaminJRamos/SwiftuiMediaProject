//
//  RegisterViewModel.swift
//  APITest
//
//  Created by Benjamin  Ramos on 10/18/23.
//

import Foundation
import SwiftUI


class RegistrationViewModel: ObservableObject {
    
    
    
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    

    func createUser() async throws {
        try await AuthenticationManager.shared.createUser(email: email, password: password, username: username)
        
        username = ""
        email = ""
        password = ""
        
    }
}

