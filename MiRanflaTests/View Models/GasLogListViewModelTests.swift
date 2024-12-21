//
//  GasLogListViewModelTests.swift
//  MiRanflaTests
//
//  Created by Uriel Hernandez Gonzalez on 09/11/24.
//

@testable import MiRanfla
import XCTest

final class GasLogListViewModelTests: XCTestCase {

    var sut: GasLogListViewModel!
    var mockAdapter: MockCarAdapter!
    
    override func setUp() {
        super.setUp()
        mockAdapter = MockCarAdapter()
        sut = GasLogListViewModel(logs: UIGasLog.mockLogs, adapter: mockAdapter)
    }

    override func tearDown() {
        mockAdapter = nil
        sut = nil
        super.tearDown()
    }
    
    func testDelete() {
        let logToRemove = UIGasLog.mockLogs.first!

        // Adapter doesn´t throw
        sut.delete(logToRemove)

        XCTAssertEqual(mockAdapter.receivedUUID, logToRemove.id)
        XCTAssertFalse(sut.logs.contains(where: { $0.id == logToRemove.id }))
        XCTAssertFalse(sut.showError)

        // Adapter throws
        mockAdapter.deleteResult = .failure(NSError(domain: "com.miranfla.tests", code: 10))
        sut.delete(.empty)

        XCTAssertTrue(sut.showError)
    }

    func testRefreshData() {
        // When doesn´t throw
        mockAdapter.fetchResult = .success([.previewCar])

        sut.refreshData(for: UUID())

        XCTAssertNotNil(mockAdapter.receivedDescriptor?.predicate)
        XCTAssertFalse(sut.showError)
        XCTAssertEqual(sut.logs, UICar.previewCar.gasLogs)

        // When it throws
        mockAdapter.fetchResult = .failure(NSError(domain: "com.miranfla.tests", code: 10))

        sut.refreshData(for: UUID())
        XCTAssertTrue(sut.showError)
    }
}
