//
//  ContentVM.swift
//  APITest
//
//  Created by Benjamin  Ramos on 10/20/23.
//

import Foundation
import Firebase
import Combine
import FirebaseAuth

@MainActor
final class ContentViewModel: ObservableObject {
    
    private let service = AuthenticationManager.shared
    private var cancellables = Set<AnyCancellable>()
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User_fornow?
    
    @MainActor
    init() {
        setupSubscribersForStart()
    }
  @MainActor
    func setupSubscribersForStart() {
        service.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
             
        }
        .store(in: &cancellables)
        
        service.$currentUser.sink { [weak self] currentUser in
            self?.currentUser = currentUser
             
        }
        .store(in: &cancellables)
    }
}
