//
//  AddCarModelTransformerTests.swift
//  MiRanflaTests
//
//  Created by Uriel Hernandez Gonzalez on 09/09/24.
//

@testable import MiRanfla
import XCTest
import SwiftData

final class AddCarModelTransformerTests: XCTestCase {
    // swiftlint:disable:next force_try
    let container = try! ModelContainer(for: Car.self, configurations: .init(isStoredInMemoryOnly: true))

    var sut: AddCarModelTransformer!

    override func setUp() {
        super.setUp()
        sut = AddCarModelTransformer()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testTransformToStorageModelThrowsWhenInvalidYearOrIntValuesAreProvided() throws {
        // Given
        let mockCarData = CarDataFormModel(id: .init(), make: "", model: "", year: "2024", lastPlateNumber: "4")
        let mockCarSpecsData = CarSpecsFormModel(milage: "100",
                                                 tankCapacity: "20",
                                                 plateState: .aguascalientes,
                                                 verificationNotifications: true)

        // When
        let transformedCar = try sut.transformToStorageModel(from: mockCarData, and: mockCarSpecsData)

        // Then
        XCTAssertEqual(transformedCar.make, mockCarData.make)
        XCTAssertEqual(transformedCar.model, mockCarData.model)
        XCTAssertEqual(transformedCar.year, try UInt(mockCarData.year, format: .number))
        XCTAssertEqual(transformedCar.lastPlateNumber, try UInt(mockCarData.lastPlateNumber, format: .number))
        XCTAssertEqual(transformedCar.milage, try UInt(mockCarSpecsData.milage, format: .number))
        XCTAssertEqual(transformedCar.tankCapacity, try UInt(mockCarSpecsData.tankCapacity, format: .number))
        XCTAssertEqual(transformedCar.plateState.rawValue, mockCarSpecsData.plateState.rawValue)
    }

    func testTransformToStorageModelDefaultsToCDMXWhenRawValueIsNotCorrect() throws {
        // Given
        let mockCarData = CarDataFormModel(id: .init(), make: "", model: "", year: "2024", lastPlateNumber: "4")
        let mockCarSpecsData = CarSpecsFormModel(milage: "100",
                                                 tankCapacity: "20",
                                                 plateState: .test,
                                                 verificationNotifications: true)

        // When
        let car = try sut.transformToStorageModel(from: mockCarData, and: mockCarSpecsData)

        // Then
        XCTAssertEqual(car.plateState.rawValue, UIStateInMexico.cdmx.rawValue)
    }

    func testTransformToUIModel() {
        // Given
        let mockCar = Car(make: "Toyota",
                          model: "Hillux",
                          year: 2024,
                          lastPlateNumber: 4,
                          milage: 160,
                          tankCapacity: 60,
                          plateState: .aguascalientes,
                          verificationNotificationsEnabled: true)

        // When
        let uiCar = sut.transformToUIModel(from: mockCar)

        // Then
        XCTAssertEqual(uiCar.id, mockCar.id)
        XCTAssertEqual(uiCar.make, mockCar.make)
        XCTAssertEqual(uiCar.model, mockCar.model)
        XCTAssertEqual(uiCar.year, String(describing: mockCar.year))
        XCTAssertEqual(uiCar.lastPlateNumber, String(describing: mockCar.lastPlateNumber))
        XCTAssertEqual(uiCar.milage, String(describing: mockCar.milage))
        XCTAssertEqual(uiCar.tankCapacity, String(describing: mockCar.tankCapacity))
        XCTAssertEqual(uiCar.plateState, .aguascalientes)
        XCTAssertEqual(uiCar.verificationNotificationsEnabled, mockCar.verificationNotificationsEnabled)
    }
}
