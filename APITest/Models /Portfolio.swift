//
//  Portfolio.swift
//  APITest
//
//  Created by Benjamin  Ramos on 11/23/23.
//

import Foundation


struct Portfolio: Identifiable, Hashable, Codable {
    let id: String
    let ownerUid: String
    let imageUrl: [String]
    var user: User_fornow?
}

extension Portfolio{
    static var MOCK_Portfolios: [Portfolio] = [
        .init(id:  NSUUID().uuidString,
              ownerUid: NSUUID().uuidString,
              imageUrl: ["Fix My Lawn"],
              user: User_fornow.Mock_USERS[0]),
        
            .init(id:  NSUUID().uuidString,
                  ownerUid: NSUUID().uuidString,
                  imageUrl: ["IMG_0442"],
                  user: User_fornow.Mock_USERS[1]),
        
        .init(id:  NSUUID().uuidString,
              ownerUid: NSUUID().uuidString,
              imageUrl: ["Fix My Lawn"],
              user: User_fornow.Mock_USERS[2])
    ]
}
