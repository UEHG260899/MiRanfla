//
//  MockNotificationObserver.swift
//  MiRanflaTests
//
//  Created by Uriel Hernandez Gonzalez on 11/09/24.
//

@testable import MiRanfla
import Foundation

final class MockNotificationObserver: NotificationsObserving {
    struct CalledMethods: OptionSet {
        let rawValue: Int
        
        static let addObserver = CalledMethods(rawValue: 1 << 0)
        static let removeObserver = CalledMethods(rawValue: 1 << 1)
    }
    
    var calledMethods: CalledMethods = []
    
    func addObserver(_ observer: Any, selector: Selector, name aName: NSNotification.Name?, object: Any?) {
        calledMethods.insert(.addObserver)
    }
    
    func removeObserver(_ observer: Any) {
        calledMethods.insert(.removeObserver)
    }
}
