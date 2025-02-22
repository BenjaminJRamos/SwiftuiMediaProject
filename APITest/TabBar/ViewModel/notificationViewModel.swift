//
//  notificationViewModel.swift
//  APITest
//
//  Created by Benjamin  Ramos on 1/5/24.
//

import Foundation
import Firebase
import UserNotifications

class notificationViewModel: ObservableObject {
    @Published var notifications = [Notification_ForNow]()
    private let user: User_fornow
    // FETCH NOTIFICATION FUNCTION
    @MainActor
    init(user: User_fornow){
        self.user = user
        
        Task{ try await getNotis() }
        
    }
    
    @MainActor
    func getNotis() async throws {
        Task{
            self.notifications = try await notificationService.fetchNotification(uid: user.id)
        }
    }
    
    // LISTENER
    @MainActor
    func addListenerForNoti() {
        AuthenticationManager.shared.listenForNotifications {
            [weak self] products in
            
            self?.notifications = products
            Task{ try await self?.getNotis() }
         
        }
    }
    
    // NOTIFICATION SCREEN
    
    func notiTest() {
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
