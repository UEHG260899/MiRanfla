//
//  NotificationCenter+NotificationsObserving.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 11/09/24.
//

import Foundation

protocol NotificationsObserving {
    func addObserver(_ observer: Any, selector: Selector, name aName: NSNotification.Name?, object: Any?)
    func removeObserver(_ observer: Any)
}


extension NotificationCenter: NotificationsObserving {}
