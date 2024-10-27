//
//  HomeViewModelTests.swift
//  MiRanflaTests
//
//  Created by Uriel Hernandez Gonzalez on 17/09/24.
//
@testable import MiRanfla
import XCTest

final class HomeViewModelTests: XCTestCase {

    var sut: HomeViewModel!
    var mockAdapter: MockCarAdapter!

    override func setUp() {
        super.setUp()
        mockAdapter = MockCarAdapter()
        sut = HomeViewModel(adapter: mockAdapter)
    }

    override func tearDown() {
        mockAdapter = nil
        sut = nil
        super.tearDown()
    }

    func testInitialValues() {
        XCTAssertTrue(sut.cars.isEmpty)
        XCTAssertTrue(sut.filteredCars.isEmpty)
        XCTAssertTrue(sut.searchQuery.isEmpty)
        XCTAssertFalse(sut.showError)
        XCTAssertFalse(sut.showAddCarView)
    }

    func testFetchCars() {
        let mockCars = [UICar(id: .init(),
                              make: "",
                              model: "",
                              year: "",
                              lastPlateNumber: "",
                              milage: "",
                              tankCapacity: "",
                              plateState: .bajaCalifornia,
                              gasLogs: UIGasLog.mockLogs,
                              verificationNotificationsEnabled: true)]

        mockAdapter.fetchResult = .success(mockCars)

        sut.fetchCars()

        XCTAssertFalse(sut.cars.isEmpty)
        XCTAssertEqual(sut.cars.count, 1)
        XCTAssertEqual(sut.cars.count, sut.filteredCars.count)
        XCTAssertEqual(mockAdapter.receivedDescriptor?.sortBy, [SortDescriptor(\Car.make)])

        mockAdapter.fetchResult = .failure(NSError(domain: "com.miranfla.tests", code: 10))

        sut.fetchCars()

        XCTAssertTrue(sut.showError)
    }

    func testFilterResults() {
        let mockCars = [UICar(id: .init(),
                              make: "Toyota",
                              model: "",
                              year: "",
                              lastPlateNumber: "",
                              milage: "",
                              tankCapacity: "",
                              plateState: .bajaCalifornia,
                              gasLogs: UIGasLog.mockLogs,
                              verificationNotificationsEnabled: true),
                        UICar(id: .init(),
                              make: "VW",
                              model: "",
                              year: "",
                              lastPlateNumber: "",
                              milage: "",
                              tankCapacity: "",
                              plateState: .bajaCalifornia,
                              gasLogs: UIGasLog.mockLogs,
                              verificationNotificationsEnabled: true)]

        mockAdapter.fetchResult = .success(mockCars)

        sut.fetchCars()

        // When query is empty
        XCTAssertEqual(sut.cars, sut.filteredCars)

        // When query contains soething
        sut.searchQuery = "Toyota"

        XCTAssertEqual(sut.filteredCars.count, 1)
        XCTAssertEqual(sut.cars.count, 2)
    }

}
