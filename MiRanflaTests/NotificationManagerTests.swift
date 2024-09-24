//
//  NotificationManagerTests.swift
//  MiRanflaTests
//
//  Created by Uriel Hernandez Gonzalez on 13/09/24.
//

@testable import MiRanfla
import XCTest

final class NotificationManagerTests: XCTestCase {

    var sut: NotificationsManager!
    var mockNotificationCenter: MockUNNotificationCenter!

    override func setUp() {
        super.setUp()
        mockNotificationCenter = MockUNNotificationCenter()
        sut = NotificationsManager(notificationCenter: mockNotificationCenter)
    }

    override func tearDown() {
        mockNotificationCenter = nil
        sut = nil
        super.tearDown()
    }

    func testRequestPermissions() async throws {
        // When
        _ = try await sut.requestPermissions()

        // Then
        XCTAssertTrue(mockNotificationCenter.calledMethods.contains(.requestAuthorization))
        XCTAssertEqual(mockNotificationCenter.receivedOptions, [.alert, .badge, .sound])
    }

    func testSchedule() async throws {
        // Given)
        let mockNotification = LocalNotification(id: "Id", month: 10, title: "Some title", body: "Some body")
        let expectedTrigger = UNCalendarNotificationTrigger(dateMatching: .init(month: mockNotification.month,
                                                                                day: 1,
                                                                                hour: 9),
                                                            repeats: true)

        // When
        try await sut.schedule(mockNotification)

        // Then
        XCTAssertTrue(mockNotificationCenter.calledMethods.contains(.add))
        XCTAssertEqual(mockNotificationCenter.receivedNotificationRequest?.content.title, mockNotification.title)
        XCTAssertEqual(mockNotificationCenter.receivedNotificationRequest?.content.body, mockNotification.body)
        XCTAssertEqual(mockNotificationCenter.receivedNotificationRequest?.trigger, expectedTrigger)
    }

    func testRemoveNotifications() {
        // When
        sut.removeNotifications(for: "")

        // Then
        XCTAssertTrue(mockNotificationCenter.calledMethods.contains(.removePendingNotificationRequests))
        XCTAssertTrue(mockNotificationCenter.calledMethods.contains(.removeDeliveredNotifications))
    }

}
