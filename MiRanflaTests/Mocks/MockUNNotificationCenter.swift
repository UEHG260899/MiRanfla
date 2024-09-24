//
//  MockUNNotificationCenter.swift
//  MiRanflaTests
//
//  Created by Uriel Hernandez Gonzalez on 13/09/24.
//

@testable import MiRanfla
import UserNotifications

final class MockUNNotificationCenter: NotificationCenterProviding {

    struct CalledMethods: OptionSet {
        let rawValue: Int

        static let requestAuthorization = CalledMethods(rawValue: 1 << 0)
        static let add = CalledMethods(rawValue: 1 << 0)
        static let removeDeliveredNotifications = CalledMethods(rawValue: 1 << 2)
        static let removePendingNotificationRequests = CalledMethods(rawValue: 1 << 3)
    }

    var calledMethods: CalledMethods = []
    var receivedOptions: UNAuthorizationOptions = []
    var receivedNotificationRequest: UNNotificationRequest?
    var authorizationReturn: Result<Bool, Error> = .success(true)

    func requestAuthorization(options: UNAuthorizationOptions) async throws -> Bool {
        calledMethods.insert(.requestAuthorization)
        receivedOptions = options

        switch authorizationReturn {
        case .success(let success):
            return success
        case .failure(let failure):
            throw failure
        }
    }

    func add(_ request: UNNotificationRequest) async throws {
        calledMethods.insert(.add)
        receivedNotificationRequest = request
    }

    func removeDeliveredNotifications(withIdentifiers: [String]) {
        calledMethods.insert(.removeDeliveredNotifications)
    }

    func removePendingNotificationRequests(withIdentifiers: [String]) {
        calledMethods.insert(.removePendingNotificationRequests)
    }

}
