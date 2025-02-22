//
//  PortfolioPresentationViewModel.swift
//  APITest
//
//  Created by Benjamin  Ramos on 11/25/23.
//

import Foundation

class PostGridViewModel: ObservableObject {
    private let user: User_fornow
    @Published var portfolios = [Portfolio]()
    
    init(user: User_fornow) {
        self.user = user
        
        Task { try await fetchUserPortfolio() }
    }
    
    // LISTENER
    @MainActor
    func addListenerForPortfolios() {
        AuthenticationManager.shared.addListenerToPortfolio { [weak self] products in
            self?.portfolios = products
            Task { try await self?.fetchUserPortfolio()}
        }
    }
    
    
    @MainActor
    func fetchUserPortfolio() async throws {
        self.portfolios = try await PostService.fetchUserPortfolios(uid: user.id)
        
        for i in 0 ..< portfolios.count {
            portfolios[i].user = self.user
        }
    }
}
