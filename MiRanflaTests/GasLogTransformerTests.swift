//
//  GasLogTransformerTests.swift
//  MiRanflaTests
//
//  Created by Uriel Hernandez Gonzalez on 26/10/24.
//

@testable import MiRanfla
import XCTest

final class GasLogTransformerTests: XCTestCase {

    private let sut = GasLogTransformer()
    private let mockCar = Car(make: "",
                              model: "",
                              year: 10,
                              lastPlateNumber: 10,
                              milage: 10,
                              tankCapacity: 10,
                              plateState: .estadoDeMexico,
                              verificationNotificationsEnabled: true)

    func testTransformToStorageModel() {
        var formData = GasLogFormData(date: .now,
                                      price: "100",
                                      liters: "100",
                                      milage: "100")

        // When form data can be cast to numerical values
        var storageLog = sut.transformToStorageModel(from: formData, associatedCar: mockCar)

        XCTAssertTrue(storageLog.car === mockCar)
        XCTAssertEqual(storageLog.id, formData.id)
        XCTAssertEqual(storageLog.date, formData.date)
        XCTAssertEqual(storageLog.price, Decimal(string: formData.price)!)
        XCTAssertEqual(storageLog.liters, Double(formData.liters)!)
        XCTAssertEqual(storageLog.milage, Int(formData.milage)!)

        // When form data can´t be cast to numerical values
        formData = GasLogFormData(date: .now,
                                      price: "a",
                                      liters: "a",
                                      milage: "a")

        storageLog = sut.transformToStorageModel(from: formData, associatedCar: mockCar)

        XCTAssertEqual(storageLog.price, 0)
        XCTAssertEqual(storageLog.liters, 0)
        XCTAssertEqual(storageLog.milage, 0)
    }

    func testTransformToUIModel() {
        let mockLog = GasLog(date: .now, price: 100, liters: 1, milage: 10, car: mockCar)

        let uiLog = sut.transformToUIModel(from: mockLog)

        XCTAssertEqual(uiLog.id, mockLog.id)
        XCTAssertEqual(uiLog.date, mockLog.date)
        XCTAssertEqual(uiLog.price, mockLog.price)
        XCTAssertEqual(uiLog.liters, mockLog.liters)
        XCTAssertEqual(uiLog.milage, mockLog.milage)
    }

}
