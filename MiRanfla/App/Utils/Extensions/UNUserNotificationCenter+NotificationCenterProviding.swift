//
//  UNUserNotificationCenter+NotificationCenterProviding.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 13/09/24.
//

import UserNotifications

protocol NotificationCenterProviding {
    func requestAuthorization(options: UNAuthorizationOptions) async throws -> Bool
    func add(_ request: UNNotificationRequest) async throws
    func removeDeliveredNotifications(withIdentifiers: [String])
    func removePendingNotificationRequests(withIdentifiers: [String])
}

extension UNUserNotificationCenter: NotificationCenterProviding {}
