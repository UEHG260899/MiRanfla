//
//  EditCarViewModelTests.swift
//  MiRanflaTests
//
//  Created by Uriel Hernandez Gonzalez on 02/10/24.
//

@testable import MiRanfla
import XCTest

final class EditCarViewModelTests: XCTestCase {

    func testInit() {
        let mockAdapter = MockCarAdapter()
        let sut = EditCarViewModel(car: .empty, adapter: mockAdapter)

        XCTAssertFalse(sut.showError)
        // CarData
        XCTAssertEqual(sut.carDataForm.id, UICar.empty.id)
        XCTAssertEqual(sut.carDataForm.make, UICar.empty.make)
        XCTAssertEqual(sut.carDataForm.model, UICar.empty.model)
        XCTAssertEqual(sut.carDataForm.year, UICar.empty.year)
        XCTAssertEqual(sut.carDataForm.lastPlateNumber, UICar.empty.lastPlateNumber)

        // Car Specs
        XCTAssertEqual(sut.carSpecsForm.milage, UICar.empty.milage)
        XCTAssertEqual(sut.carSpecsForm.tankCapacity, UICar.empty.tankCapacity)
        XCTAssertEqual(sut.carSpecsForm.plateState.rawValue, UICar.empty.plateState.rawValue)
        XCTAssertEqual(sut.carSpecsForm.verificationNotifications, UICar.empty.verificationNotificationsEnabled)
    }

    func testSave() {
        let mockAdapter = MockCarAdapter()
        let sut = EditCarViewModel(car: .empty, adapter: mockAdapter)

        // When plate state needs to verify
        sut.save()

        XCTAssertTrue(sut.carSpecsForm.verificationNotifications)

        // When plate state doesn´t need verifiation
        sut.carSpecsForm.plateState = .aguascalientes
        sut.save()

        XCTAssertFalse(sut.carSpecsForm.verificationNotifications)

        // When saving throws
        mockAdapter.saveResult = .failure(NSError(domain: "com.miranfla.tests", code: 10))

        sut.save()

        XCTAssertTrue(sut.showError)
    }
}
