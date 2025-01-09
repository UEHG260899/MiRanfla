//
//  NotificationCenter+NotificationsObserving.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 11/09/24.
//

import Foundation

protocol NotificationsObserving {
    func addObserver(_ observer: Any, selector: Selector, name aName: NSNotification.Name?, object: Any?)
    func removeObserver(_ observer: Any, name: NSNotification.Name?, object: Any?)
}

protocol NotificationsPosting {
    func post(name: NSNotification.Name, object: Any?)
}

extension NotificationCenter: NotificationsObserving, NotificationsPosting {}

extension Notification.Name {
    static let allCarsDeletedNotification = Notification.Name("all-cars-deleted")
}
