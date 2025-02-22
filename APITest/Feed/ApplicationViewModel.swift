//
//  ApplicationViewModel.swift
//  APITest
//
//  Created by Benjamin  Ramos on 1/5/24.
//

import Foundation
import UserNotifications

enum NotificationAction: String {
    case dismiss
    case reminder
}

enum NotificationCategory: String {
    case general
}

class ApplicationViewModel: ObservableObject {
    
    var applicationService: notificationService
    
    init(user: User_fornow, post: Post){
        self.applicationService = notificationService(user: user)
    }
    // FUNCTION THAT SENDS NOTIFICATIONS' TO FIRESTORE
    func sendApplication(post: Post) {
        applicationService.applyToTheJob(post: post)
    }
    
    func triggerLocalNotification() {
        let center = UNUserNotificationCenter.current()
        
        // NOTIFICATION CONTENT
        let content = UNMutableNotificationContent()
        content.body = "Hop into Fix My Lawn to get your lawn fixed!"
        content.title = "Someone has applied for your job"
        content.categoryIdentifier = NotificationCategory.general.rawValue
       // content.badge = 1
        
        // TRIGGER
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3.0, repeats: false)
        
        // REQUEST
        let request = UNNotificationRequest(identifier: "Identifier", content: content, trigger: trigger)
        
        // DEFINING ACTIONS
        let dismiss = UNNotificationAction(identifier: NotificationAction.dismiss.rawValue, title: "Dismiss", options: [])
        
        let reminder = UNNotificationAction(identifier: NotificationAction.reminder.rawValue, title: "Reminder", options: [])
        
        let generalCategory = UNNotificationCategory(identifier: NotificationCategory.general.rawValue, actions: [dismiss, reminder], intentIdentifiers: [], options: [])
        
        center.setNotificationCategories([generalCategory])
        
        // ADD REQUEST TO NOTIFICATION CENTER
        center.add(request) { error in
            if let error = error {
                print(error)
            }
        }
    }
    
    func bareBoneNoti() {
        let bareCenter = UNUserNotificationCenter.current()
        
        // CONTENT:
        let bareContent = UNMutableNotificationContent()
        bareContent.title = "Hop into fix my lawn"
        bareContent.body = "Somebody has applied to your job!"
        
        // TRIGGER:
        let bareTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 3.0, repeats: false)
        
        // REQUEST:
        let request = UNNotificationRequest(identifier: "Identifier", content: bareContent, trigger: bareTrigger)
        
        // NOTIFICATION CENTER:
        bareCenter.add(request) { error in
            if let error = error {
                print(error)
            }
        }
    }
}
