//
//  PortfolioView.swift
//  APITest
//
//  Created by Benjamin  Ramos on 11/25/23.
//

import SwiftUI

struct PortfolioView: View {
    let user: User_fornow
    

    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1)
        ]
    
    var body: some View {
        ScrollView {
            //header
            PortolioHeaderView(user: user)

            //post grid View
            PortfolioPresentationView(user: user)
            
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
   
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView(user: User_fornow.Mock_USERS[0])
    }
}
