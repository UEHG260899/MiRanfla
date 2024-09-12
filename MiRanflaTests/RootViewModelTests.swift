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
        let notificationsProvider = MockNotificationProvider()
        adapter.returningCars = 1

        // When
        let sut = RootViewModel(adapter: adapter, notificationsProvider: notificationsProvider)
        
        // Then
        XCTAssertEqual(sut.screenToShow, .home)
        XCTAssertFalse(notificationsProvider.calledMethods.contains(.addObserver))
    }

    func testInitWhenNoCarsAreStored() {
        // Given
        let adapter = MockCarAdapter()
        let notificationsProvider = MockNotificationProvider()

        // When
        let sut = RootViewModel(adapter: adapter, notificationsProvider: notificationsProvider)
        
        // Then
        XCTAssertEqual(sut.screenToShow, .noCar)
        XCTAssertTrue(notificationsProvider.calledMethods.contains(.addObserver))
    }
    
    func testShowHome() async {
        // Given
        let adapter = MockCarAdapter()
        let notificationsProvider = MockNotificationProvider()

        let sut = RootViewModel(adapter: adapter, notificationsProvider: notificationsProvider)
        
        // When
        sut.showHome()
        try? await Task.sleep(for: .milliseconds(200))
        
        
        // Then
        XCTAssertEqual(sut.screenToShow, .home)
        XCTAssertTrue(notificationsProvider.calledMethods.contains(.removeObserver))
    }
}
