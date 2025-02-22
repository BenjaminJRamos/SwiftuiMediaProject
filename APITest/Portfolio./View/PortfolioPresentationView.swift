//
//  PortfolioPresentationView.swift
//  APITest
//
//  Created by Benjamin  Ramos on 11/25/23.
//

import SwiftUI
import Kingfisher


struct PortfolioPresentationView: View {
    
    @StateObject var viewModel: PostGridViewModel
    @StateObject var VM: AddPortfolioViewModel
    
    init(user:User_fornow) {
        self._viewModel = StateObject(wrappedValue: PostGridViewModel(user: user))
        self._VM = StateObject(wrappedValue: AddPortfolioViewModel(user: user))
    }
    
    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1)
        ]
    
    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 3) - 1
    
    var body: some View {
        
        LazyVGrid(columns: gridItems, spacing: 1) {
            ForEach(Array(viewModel.portfolios)) { post in
                PortfolioCell(portfolio: post)
            }
        }
        
        .onAppear {
            viewModel.addListenerForPortfolios()
            VM.addListenerForBioAndName()
        }
    }
}

struct PortfolioPresentationView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioPresentationView(user: User_fornow.Mock_USERS[0])
    }
}
