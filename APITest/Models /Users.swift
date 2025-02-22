//
//  Users.swift
//  APITest
//
//  Created by Benjamin  Ramos on 9/29/23.
//


import Foundation
import Firebase
import FirebaseAuth

struct User_fornow: Identifiable, Hashable, Codable {
    var id: String
    var username: String?
    var profileImageUrl: String?
    var fullname: String?
    var bio: String?
    let email: String?
    
    
    var isCurrentUser: Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else {return false}
        return currentUid == id
    }
}

extension User_fornow {
    static var Mock_USERS: [User_fornow] = [
        .init(id: NSUUID().uuidString, username: "batman", profileImageUrl: nil, fullname: "Bruce Wane", bio: "gotham dark knight", email: "batman@gmail.com"),
        .init(id: NSUUID().uuidString, username: "Venom", profileImageUrl: nil, fullname: "Eddie Brock", bio: "Venom is black", email: "Venom@gmail.com"),
        .init(id: NSUUID().uuidString, username: "Iron man", profileImageUrl: nil, fullname: "Tony Stark", bio: "get money", email: "batman@gmail.com"),
        .init(id: NSUUID().uuidString, username: "blackpanther", profileImageUrl: nil, fullname: "Charla", bio: "Wakanda Forever", email: "blackpanther@gmail.com"),
        .init(id: NSUUID().uuidString, username: "spiderman", profileImageUrl: nil, fullname: "Peter parker", bio: "webs are nice", email: "Spiderman@gmail.com"),
    ]
}

