//
//  AddGasLogViewModelTests.swift
//  MiRanflaTests
//
//  Created by Uriel Hernandez Gonzalez on 26/10/24.
//

@testable import MiRanfla
import XCTest

final class AddGasLogViewModelTests: XCTestCase {

    var mockAdapter: MockCarAdapter!
    var sut: AddGasLogViewModel!

    override func setUp() {
        super.setUp()
        mockAdapter = MockCarAdapter()
        sut = AddGasLogViewModel(carId: .init(), carAdapter: mockAdapter)
    }

    override func tearDown() {
        mockAdapter = nil
        sut = nil
        super.tearDown()
    }

    func testInit() {
        XCTAssertEqual(sut.gasLogFormData, .empty)
        XCTAssertFalse(sut.showError)
    }

    func testSave() {
        // Doesn´t throw
        sut.save()

        XCTAssertFalse(sut.showError)

        // Throws
        mockAdapter.addResult = .failure(NSError(domain: "com.miranfla.test", code: 10))

        sut.save()

        XCTAssertTrue(sut.showError)
    }
}