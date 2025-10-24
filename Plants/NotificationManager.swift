//
//  NotificationManager.swift
//  Plants
//
//  Created by Fay  on 23/10/2025.
//
import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    private init() {}

    func requestAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("❌ Notification permission error: \(error.localizedDescription)")
            } else {
                print(granted ? "✅ Notifications allowed" : "⚠️ Notifications denied")
            }
        }
    }

    func scheduleNotification(for plant: Plant) {
        let content = UNMutableNotificationContent()
        content.title = "Water Reminder 🌿"
        content.body = "It's time to water \(plant.name)"
        content.sound = .default
        
        let interval: TimeInterval
        switch plant.water {
        case "EveryDay":
            interval = 24 * 60 * 60
        case "Every 2 Days":
            interval = 2 * 24 * 60 * 60
        case "Weekly":
            interval = 7 * 24 * 60 * 60
        default:
            interval = 24 * 60 * 60
        }

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: true)
        let request = UNNotificationRequest(identifier: plant.id.uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Failed to schedule notification for \(plant.name): \(error.localizedDescription)")
            } else {
                print("✅ Notification scheduled for \(plant.name)")
            }
        }
    }
    
    func removeNotification(for plant: Plant) {
           UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [plant.id.uuidString])
       }
    
    
    //test
    func scheduleTestNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Planto"
        content.body = "Hey! lets water your plant"
        content.sound = .default

        // Trigger after 5 seconds
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 30, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Error scheduling test notification: \(error.localizedDescription)")
            } else {
                print("✅ Test notification scheduled to appear in 5 seconds")
            }
        }
    }
}
