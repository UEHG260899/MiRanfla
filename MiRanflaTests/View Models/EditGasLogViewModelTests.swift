//
//  EditGasLogViewModelTests.swift
//  MiRanflaTests
//
//  Created by Uriel Hernandez Gonzalez on 27/11/24.
//

@testable import MiRanfla
import XCTest

final class EditGasLogViewModelTests: XCTestCase {

    func testInit() {
        let sut = EditGasLogViewModel(log: .empty, adapter: MockCarAdapter())

        XCTAssertEqual(sut.formData.id, UIGasLog.empty.id)
        XCTAssertEqual(sut.formData.date, UIGasLog.empty.date)
        XCTAssertEqual(sut.formData.liters, String(describing: UIGasLog.empty.liters))
        XCTAssertEqual(sut.formData.milage, String(describing: UIGasLog.empty.milage))
        XCTAssertEqual(sut.formData.price, String(describing: UIGasLog.empty.price))
        XCTAssertFalse(sut.showError)
    }

    func testSave() {
        let mockAdapter = MockCarAdapter()
        let sut = EditGasLogViewModel(log: .empty, adapter: mockAdapter)
        let id = UUID()

        // When it throws
        mockAdapter.addResult = .failure(NSError(domain: "com.miranfla.tests", code: 10))
        sut.save(with: id)

        XCTAssertTrue(sut.showError)
    }
}
