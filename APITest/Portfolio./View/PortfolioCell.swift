//
//  PortfolioCell.swift
//  APITest
//
//  Created by Benjamin  Ramos on 11/25/23.
//

import SwiftUI
import Kingfisher

struct PortfolioCell: View {
    
    let portfolio: Portfolio
    var body: some View {
        VStack{
            TabView{
                ForEach(Array(portfolio.imageUrl), id: \.self){
                    images in
                    KFImage(URL(string: images))
                        .resizable()
                        .scaledToFill()
                        .frame(height: 400)
                        .clipShape(Rectangle())

                }
            }
            .frame(height: 400)
            .tabViewStyle(PageTabViewStyle())
        }
    }
}

struct PortfolioCell_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioCell(portfolio: Portfolio.MOCK_Portfolios[0])
    }
}
