//
//  RootViewModelTests.swift
//  MiRanflaTests
//
//  Created by Uriel Hernandez Gonzalez on 11/09/24.
//

@testable import MiRanfla
import XCTest

final class RootViewModelTests: XCTestCase {

    func testInitProperties() {
        let sut = RootViewModel(adapter: MockCarAdapter())
        XCTAssertEqual(sut.screenToShow, .noCar)
    }

    func testInitWhenCarsAreStored() {
        // Given
        let adapter = MockCarAdapter()
        let notificationObserver = MockNotificationObserver()
        adapter.returningCarsCount = 1

        // When
        let sut = RootViewModel(adapter: adapter, notificationsObserver: notificationObserver)

        // Then
        XCTAssertEqual(sut.screenToShow, .home)
        XCTAssertFalse(notificationObserver.calledMethods.contains(.addObserver))
    }

    func testInitWhenNoCarsAreStored() {
        // Given
        let adapter = MockCarAdapter()
        let notificationObserver = MockNotificationObserver()

        // When
        let sut = RootViewModel(adapter: adapter, notificationsObserver: notificationObserver)

        // Then
        XCTAssertEqual(sut.screenToShow, .noCar)
        XCTAssertTrue(notificationObserver.calledMethods.contains(.addObserver))
    }

    func testShowHome() async {
        // Given
        let adapter = MockCarAdapter()
        let notificationObserver = MockNotificationObserver()

        let sut = RootViewModel(adapter: adapter, notificationsObserver: notificationObserver)

        // When
        sut.showHome()
        try? await Task.sleep(for: .milliseconds(50))

        // Then
        XCTAssertEqual(sut.screenToShow, .home)
        XCTAssertTrue(notificationObserver.calledMethods.contains(.removeObserver))
    }

    func testShowNoCarView() async {
        // Given
        let adapter = MockCarAdapter()
        let notificationObserver = MockNotificationObserver()

        let sut = RootViewModel(adapter: adapter, notificationsObserver: notificationObserver)

        // When
        sut.showNoCarView()
        try? await Task.sleep(for: .microseconds(50))

        // Then
        XCTAssertEqual(sut.screenToShow, .noCar)
    }
}
