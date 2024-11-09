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
        XCTAssertFalse(sut.showDeletePrompt)
        XCTAssertNil(sut.presentedScreen)
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
                    gasLogs: UIGasLog.mockLogs,
                    verificationNotificationsEnabled: false)

        sut = CarInfoViewModel(uiCar: car,
                               adapter: mockAdapter,
                               notificationsManager: NotificationsManager(notificationCenter: mockNotificationsCenter))

        XCTAssertFalse(sut.shouldShowNotificationsRow)
    }

    func testConfigureNotifications() async {
        // Toggle is OFF
        await sut.manageNotifications(toggleState: false)

        XCTAssertTrue(mockNotificationsCenter.calledMethods.contains(.removeDeliveredNotifications))
        XCTAssertTrue(mockNotificationsCenter.calledMethods.contains(.removePendingNotificationRequests))

        // Toggle is ON AND permissions throw
        mockNotificationsCenter.authorizationReturn = .failure(NSError(domain: "com.miranfla.tests", code: 10))
        await sut.manageNotifications(toggleState: true)

        XCTAssertTrue(sut.showError)

        // Toggle is ON AND permissions are denied
        mockNotificationsCenter.authorizationReturn = .success(false)
        await sut.manageNotifications(toggleState: true)

        XCTAssertFalse(sut.uiCar.verificationNotificationsEnabled)

        // Toggle is ON AND permissions are granted
        sut.uiCar.verificationNotificationsEnabled = true
        mockNotificationsCenter.authorizationReturn = .success(true)
        await sut.manageNotifications(toggleState: true)

        XCTAssertTrue(mockNotificationsCenter.calledMethods.contains(.add))
        XCTAssertEqual(mockNotificationsCenter.receivedNotificationRequest?.identifier, car.id.uuidString)
        XCTAssertEqual(mockNotificationsCenter.receivedNotificationRequest?.content.title,
                       "¡No te olvides de verificar!")
        XCTAssertEqual(mockNotificationsCenter.receivedNotificationRequest?.content.body,
                       "Tu \(car.make) \(car.model) verifica este mes.")
    }

    func testDeleteCar() {
        // When doesn´t throw
        sut.deleteCar()

        XCTAssertEqual(sut.uiCar.id, mockAdapter.receivedUUID)

        // When it throws
        mockAdapter.deleteResult = .failure(NSError(domain: "com.miranfla.tests", code: 10))
        sut.deleteCar()

        XCTAssertTrue(sut.showError)
    }

    func testRefreshData() {
        // When doesn´t throw
        mockAdapter.fetchResult = .success([.previewCar])
        sut.refreshData()

        XCTAssertNotNil(mockAdapter.receivedDescriptor?.predicate)
        XCTAssertFalse(sut.showError)
        XCTAssertEqual(sut.uiCar, .previewCar)

        // When throws
        mockAdapter.fetchResult = .failure(NSError(domain: "com.miranfla.tests", code: 10))

        sut.refreshData()

        XCTAssertTrue(sut.showError)
    }
}
