//
//  Posts.swift
//  APITest
//
//  Created by Benjamin  Ramos on 9/29/23.
//

import Foundation
import Firebase

struct Post: Identifiable, Hashable, Codable {
    let id: String
    let ownerUid: String
    let caption: String
    var likes:  Int
    let imageUrl: [String] 
    let timestamp: Timestamp
    let Payment: String
    
    var user: User_fornow?
    
    var timeStampString: String{
        return timestamp.dateValue().timeStampString()
    }
}


extension Post {
    static var MOCK_POSTS: [Post] = [
        .init(
            id: NSUUID().uuidString,
              ownerUid: NSUUID().uuidString,
              caption: "Boston where you at",
              likes: 617,
              imageUrl: ["Fix My Lawn"],
            timestamp: Timestamp(),
            Payment: "20",
              user: User_fornow.Mock_USERS[0] ),
            
            .init(
        id: NSUUID().uuidString,
              ownerUid: NSUUID().uuidString,
              caption: "first post hype",
              likes: 900,
              imageUrl: ["Fix My Lawn"],
              timestamp: Timestamp(),
              Payment: "20",
              user: User_fornow.Mock_USERS[1] ),
            
        .init(
            id: NSUUID().uuidString,
             ownerUid: NSUUID().uuidString,
              caption: "bring your own bottle",
              likes: 383,
            imageUrl: ["IMG_0442"],
              timestamp: Timestamp(),
              Payment: "20",
              user: User_fornow.Mock_USERS[2] ),
        .init(
            id: NSUUID().uuidString,
              ownerUid: NSUUID().uuidString,
              caption: "We finally on Fix My Lawn",
              likes: 155, imageUrl: ["IMG_0442"],
              timestamp: Timestamp(),
              Payment: "20",
              user: User_fornow.Mock_USERS[3] ),
        
        .init(
            id: NSUUID().uuidString,
              ownerUid: NSUUID().uuidString,
              caption: "like if this app finna go crazy",
              likes: 300000, imageUrl: ["IMG_0442"],
              timestamp: Timestamp(),
              Payment: "20",
              user: User_fornow.Mock_USERS[4] )
             
             
    ]
}

// MAKING DATES READABLE FUNCTION

extension Post {
 /*
  
  
    func calanderTime() -> String {
        
        let calander = Calendar.current
        
        let components = calander.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: Date())
        
        let years = components.year
        let months = components.month
        let days = components.day
        let hours = components.hour
        let minutes = components.minutes
        let seconds = components.second
        
        if years > 0 {
            return years == 1 ? "1 year ago" : "\(years) years ago"
        }
        if months > 0 {
            return months == 1 ? "1 month ago" : "\(months) months ago"
        }
        if days > 0 {
            return days == 1 ? "1 day ago" : "\(days) days ago"
        }
        if hours > 0 {
            return hours == 1 ? "1 hour ago" : "\(hours) hours ago"
        }
        if minutes > 0 {
            return minutes == 1 ? "1 minutes ago" : "\(minutes) minutes ago"
        }
        if seconds > 0 {
            return seconds == 1 ? "1 seconds ago" : "\(seconds) years ago"
        }
        
    }
  */
}

