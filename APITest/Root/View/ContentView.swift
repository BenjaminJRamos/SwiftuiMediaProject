//
//  ContentView.swift
//  APITest
//
//  Created by Benjamin  Ramos on 10/20/23.
//

import SwiftUI
import Firebase


struct ContentView: View {
    
    @StateObject var VM = ContentViewModel()
    @StateObject var RegistrationVM = RegistrationViewModel()
    
    var body: some View {
        Group {
            if VM.userSession == nil {
                SignInView()
                    .environmentObject(RegistrationVM)
            } else if let currentUser = VM.currentUser {
                TabBarView(user: currentUser)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
