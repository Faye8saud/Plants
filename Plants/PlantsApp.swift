//
//  PlantsApp.swift
//  Plants
//
//  Created by Fay  on 19/10/2025.
//

import SwiftUI
import UserNotifications

@main
struct PlantsApp: App {
    init() {
        NotificationManager.shared.requestAuthorization()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
               .onAppear {
                    NotificationManager.shared.scheduleTestNotification()
                }
        }
    }
}
