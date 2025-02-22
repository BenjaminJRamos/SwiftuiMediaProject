//
//  DecisionVIewModel.swift
//  APITest
//
//  Created by Benjamin  Ramos on 11/21/23.
//

import Foundation
import SwiftUI

final class DecisionViewModel: ObservableObject {
   
    
    //  RESET PASSWORD BUTTON
    func resetThePassword() async throws {
       
        let authData = try AuthenticationManager.shared.GetAuthenticatedUser()
        guard let email = authData.email else {
            throw URLError(.fileDoesNotExist)
        }
        try await AuthenticationManager.shared.resetPassword(email: email)
        
    }
    
}

