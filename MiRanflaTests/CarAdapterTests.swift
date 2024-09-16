//
//  CarAdapterTests.swift
//  MiRanflaTests
//
//  Created by Uriel Hernandez Gonzalez on 10/09/24.
//

@testable import MiRanfla
import SwiftData
import XCTest

final class CarAdapterTests: XCTestCase {

    func testSave() throws {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let mockStorage = MockSwiftDataManager(container: try ModelContainer(for: Car.self, configurations: configuration))
        let sut = CarAdapter(transformer: .init(), storageManager: mockStorage)
        
        let mockData = CarDataFormModel(id: .init(), make: "", model: "", year: "2024", lastPlateNumber: "4")
        let mockSpecs = CarSpecsFormModel(milage: "100", tankCapacity: "100", plateState: .cdmx, verificationNotifications: false)
        
        // Then
        XCTAssertNoThrow(try sut.save(data: mockData, specs: mockSpecs))
        XCTAssertTrue(mockStorage.calledMethods.contains(.save))
    }

}
