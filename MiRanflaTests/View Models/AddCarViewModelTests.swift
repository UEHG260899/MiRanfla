//
//  AddCarViewModelTests.swift
//  MiRanflaTests
//
//  Created by Uriel Hernandez Gonzalez on 10/09/24.
//

@testable import MiRanfla
import XCTest

final class AddCarViewModelTests: XCTestCase {

    var sut: AddCarViewModel!
    var adapter: MockCarAdapter!
    var mockNotificationCenter: MockUNNotificationCenter!
    var notificationsManager: NotificationsManager!

    override func setUp() {
        super.setUp()
        mockNotificationCenter = MockUNNotificationCenter()
        notificationsManager = NotificationsManager(notificationCenter: mockNotificationCenter)
        adapter = MockCarAdapter()
        sut = AddCarViewModel(adapter: adapter, notificationsManager: notificationsManager)
    }

    override func tearDown() {
        sut = nil
        mockNotificationCenter = nil
        notificationsManager = nil
        adapter = nil
        super.tearDown()
    }

    func testInitialValues() {
        XCTAssertEqual(sut.carDataForm, .empty)
        XCTAssertEqual(sut.carSpecsForm, .empty)
        XCTAssertFalse(sut.showError)
        XCTAssertTrue(sut.showVerificationRow)
    }

    func testVerificationRowVisibility() {
        // Aguascalientes´s plates don´t need to verify
        sut.carSpecsForm.plateState = .aguascalientes
        XCTAssertFalse(sut.showVerificationRow)

        sut.carSpecsForm.plateState = .estadoDeMexico
        XCTAssertTrue(sut.showVerificationRow)
    }

    func testSaveWithSuccess() async {
        // When
        await sut.save()

        // Then
        XCTAssertFalse(sut.showError)
    }

    func testSaveWithError() async {
        // Given
        adapter.saveResult = .failure(NSError(domain: "com.miranfla.tests", code: 10))

        // When
        await sut.save()

        // Then
        XCTAssertTrue(sut.showError)
        XCTAssertTrue(mockNotificationCenter.calledMethods.contains(.removeDeliveredNotifications))
        XCTAssertTrue(mockNotificationCenter.calledMethods.contains(.removePendingNotificationRequests))
    }

    func testSaveWithNotifications() async {
        sut.carSpecsForm.verificationNotifications = true

        await sut.save()

        XCTAssertTrue(mockNotificationCenter.calledMethods.contains(.add))
        XCTAssertEqual(mockNotificationCenter.receivedNotificationRequest?.content.title,
                       "¡No te olvides de verificar!")
        XCTAssertEqual(mockNotificationCenter.receivedNotificationRequest?.content.body,
                       "Tu \(sut.carDataForm.make) \(sut.carDataForm.model) verifica este mes.")
    }

    func testConfigureNotifications() async {
        // When verificationNotifications is false
        sut.carSpecsForm.verificationNotifications = false

        XCTAssertFalse(mockNotificationCenter.calledMethods.contains(.requestAuthorization))

        // When verificationNotifications is true
        sut.carSpecsForm.verificationNotifications = true

        try? await Task.sleep(for: .milliseconds(100))

        XCTAssertTrue(mockNotificationCenter.calledMethods.contains(.requestAuthorization))

        // When verificationNotifications is true AND authorization is false
        mockNotificationCenter.authorizationReturn = .success(false)
        sut.carSpecsForm.verificationNotifications = true

        try? await Task.sleep(for: .milliseconds(100))

        XCTAssertTrue(mockNotificationCenter.calledMethods.contains(.requestAuthorization))
        XCTAssertFalse(sut.carSpecsForm.verificationNotifications)

        // When verificationNotifications is true AND authorization throws
        mockNotificationCenter.authorizationReturn = .failure(NSError(domain: "com.miranfla.tests", code: 10))
        sut.carSpecsForm.verificationNotifications = true

        try? await Task.sleep(for: .milliseconds(100))

        XCTAssertTrue(mockNotificationCenter.calledMethods.contains(.requestAuthorization))
        XCTAssertTrue(sut.showError)
    }

}
