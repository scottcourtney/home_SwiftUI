//
//  NotificationService.swift
//  home
//
//  Created by Scott Courtney on 1/20/23.
//

import Foundation
import UserNotifications

class NotificationService: ObservableObject {
    
    @Published private(set) var notifications: [UNNotificationRequest] = []
    @Published private(set) var authorizationStatus: UNAuthorizationStatus?
    
    func reloadAuthorizationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.authorizationStatus = settings.authorizationStatus
            }
        }
    }
    
    func setupNotificationAuth() {
        UNUserNotificationCenter.current().requestAuthorization(options:
            [.alert, .badge, .sound]) { success, error in
            if success {
                print("Access granted!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func scheduleNotification(date: Date, title: String, body: String) -> String {
        var trigger: UNNotificationTrigger?
        
        // Configure the time.
        var dateComponents = DateComponents()
        dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: date)
        dateComponents.hour = 17
        
        // Create the trigger.
        trigger = UNCalendarNotificationTrigger(
                 dateMatching: dateComponents, repeats: false)
        
//        trigger = UNTimeIntervalNotificationTrigger(timeInterval: 61, repeats: true)
        
        // Create the content.
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        // Create the request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                    content: content, trigger: trigger)

        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
           if error != nil {
              // Handle any errors.
               print("error.localizedDescription")
           }
        }
        return uuidString
    }
    
    func cancelNotification(uuidString: String) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [uuidString])
    }
    
}
