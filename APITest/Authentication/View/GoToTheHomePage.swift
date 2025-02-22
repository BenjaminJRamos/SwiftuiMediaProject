//
//  GoToTheHomePage.swift
//  APITest
//
//  Created by Benjamin  Ramos on 10/20/23.
//

import SwiftUI

struct GoToTheHomePage: View {
    @EnvironmentObject var VM: RegistrationViewModel
    
    var body: some View {
        VStack {
            Button {
                    Task{
                    try await VM.createUser()
                    }
                
            } label: {
                Text("Finish the process")
            }
        }
    }
}

struct GoToTheHomePage_Previews: PreviewProvider {
    static var previews: some View {
        GoToTheHomePage()
    }
}
