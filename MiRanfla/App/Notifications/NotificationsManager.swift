//
//  NotificationsManager.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 13/09/24.
//

import Foundation
import UserNotifications

struct NotificationsManager {
    let notificationCenter: NotificationCenterProviding
    
    init(notificationCenter: any NotificationCenterProviding = UNUserNotificationCenter.current()) {
        self.notificationCenter = notificationCenter
    }

    func requestPermissions() async throws -> Bool {
        return try await notificationCenter.requestAuthorization(options: [.alert, .badge, .sound])
    }

    func schedule(_ notification: LocalNotification) async throws {
        var dateComponents = DateComponents()
        dateComponents.hour = 9
        dateComponents.day = 1
        dateComponents.month = notification.month
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let content = UNMutableNotificationContent()
        content.title = notification.title
        content.body = notification.body
        
        let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
        try await notificationCenter.add(request)
    }

    func removeNotifications(for id: String) {
        notificationCenter.removeDeliveredNotifications(withIdentifiers: [id])
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [id])
    }
}
