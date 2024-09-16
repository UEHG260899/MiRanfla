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
    
    let container = try! ModelContainer(for: Car.self, configurations: .init(isStoredInMemoryOnly: true))
    
    func testTransformToStorageModelThrowsWhenInvalidYearOrIntValuesAreProvided() throws {
        // Given
        let mockCarData = CarDataFormModel(id: .init(), make: "", model: "", year: "2024", lastPlateNumber: "4")
        let mockCarSpecsData = CarSpecsFormModel(milage: "100", tankCapacity: "20", plateState: .aguascalientes, verificationNotifications: true)

        let sut = AddCarModelTransformer()
            
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
        let mockCarSpecsData = CarSpecsFormModel(milage: "100", tankCapacity: "20", plateState: .test, verificationNotifications: true)
        
        let sut = AddCarModelTransformer()
        
        // When
        let car = try sut.transformToStorageModel(from: mockCarData, and: mockCarSpecsData)
        
        // Then
        XCTAssertEqual(car.plateState.rawValue, UIStateInMexico.cdmx.rawValue)
    }
}
