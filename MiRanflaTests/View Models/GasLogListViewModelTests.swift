//
//  GasLogListViewModelTests.swift
//  MiRanflaTests
//
//  Created by Uriel Hernandez Gonzalez on 09/11/24.
//

@testable import MiRanfla
import XCTest

final class GasLogListViewModelTests: XCTestCase {

    func testDelete() {
        let mockAdapter = MockCarAdapter()
        let logToRemove = UIGasLog.mockLogs.first!
        let sut = GasLogListViewModel(logs: UIGasLog.mockLogs, adapter: mockAdapter)

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
}
