//
//  CarInfoViewModelTests.swift
//  MiRanflaTests
//
//  Created by Uriel Hernandez Gonzalez on 20/09/24.
//

@testable import MiRanfla
import XCTest

final class CarInfoViewModelTests: XCTestCase {

    var car: UICar!
    var sut: CarInfoViewModel!
    var mockNotificationsCenter: MockUNNotificationCenter!
    var mockAdapter: MockCarAdapter!

    override func setUp() {
        super.setUp()
        car = .empty
        mockAdapter = MockCarAdapter()
        mockNotificationsCenter = MockUNNotificationCenter()
        let notificationsManager = NotificationsManager(notificationCenter: mockNotificationsCenter)
        sut = CarInfoViewModel(uiCar: car, adapter: mockAdapter, notificationsManager: notificationsManager)
    }

    override func tearDown() {
        sut = nil
        mockAdapter = nil
        mockNotificationsCenter = nil
        car = nil
        super.tearDown()
    }

    func testInitialValues() {
        XCTAssertFalse(sut.showError)
    }

    func testShouldShowNotificationsRow() {
        XCTAssertTrue(sut.shouldShowNotificationsRow)

        car = UICar(id: .init(),
                    make: "",
                    model: "",
                    year: "",
                    lastPlateNumber: "",
                    milage: "",
                    tankCapacity: "",
                    plateState: .chiapas,
                    verificationNotificationsEnabled: false)

        sut = CarInfoViewModel(uiCar: car,
                               adapter: mockAdapter,
                               notificationsManager: NotificationsManager(notificationCenter: mockNotificationsCenter))

        XCTAssertFalse(sut.shouldShowNotificationsRow)
    }

    func testConfigureNotifications() async {
        // Notifications are enabled AND permissions throw
        sut.uiCar.verificationNotificationsEnabled = true
        mockNotificationsCenter.authorizationReturn = .failure(NSError(domain: "com.miranfla.tests", code: 10))

        try? await Task.sleep(for: .milliseconds(50))

        XCTAssertTrue(sut.showError)

        // Notifications are enabled AND permissions are denied
        sut.uiCar.verificationNotificationsEnabled = true
        mockNotificationsCenter.authorizationReturn = .success(false)

        try? await Task.sleep(for: .milliseconds(50))

        XCTAssertFalse(sut.uiCar.verificationNotificationsEnabled)

        // Notifications are disabled AND permissions are granted
        sut.uiCar.verificationNotificationsEnabled = false
        mockNotificationsCenter.authorizationReturn = .success(true)

        try? await Task.sleep(for: .milliseconds(50))

        XCTAssertTrue(mockNotificationsCenter.calledMethods.contains(.removeDeliveredNotifications))
        XCTAssertTrue(mockNotificationsCenter.calledMethods.contains(.removePendingNotificationRequests))
    }

    func testConfigureNotificationsWithPermissionGranted() async {
        sut.uiCar.verificationNotificationsEnabled = true
        mockNotificationsCenter.authorizationReturn = .success(true)

        try? await Task.sleep(for: .milliseconds(50))

        XCTAssertTrue(mockNotificationsCenter.calledMethods.contains(.add))
        XCTAssertEqual(mockNotificationsCenter.receivedNotificationRequest?.identifier, car.id.uuidString)
        XCTAssertEqual(mockNotificationsCenter.receivedNotificationRequest?.content.title,
                       "¡No te olvides de verificar!")
        XCTAssertEqual(mockNotificationsCenter.receivedNotificationRequest?.content.body,
                       "Tu \(car.make) \(car.model) verifica este mes.")
    }
}
