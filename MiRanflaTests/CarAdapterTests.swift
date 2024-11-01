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

    var sut: CarAdapter!
    var mockStorage: MockSwiftDataManager!

    override func setUp() async throws {
        try await super.setUp()
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        mockStorage = MockSwiftDataManager(container: try ModelContainer(for: Car.self,
                                                                         configurations: configuration))
        sut = CarAdapter(storageManager: mockStorage)
    }

    override func tearDown() {
        mockStorage = nil
        sut = nil
        super.tearDown()
    }

    func testSave() {
        let mockData = CarDataFormModel(id: .init(),
                                        make: "",
                                        model: "",
                                        year: "2024",
                                        lastPlateNumber: "4")
        let mockSpecs = CarSpecsFormModel(milage: "100",
                                          tankCapacity: "100",
                                          plateState: .cdmx,
                                          verificationNotifications: false)

        // Then
        XCTAssertNoThrow(try sut.save(data: mockData, specs: mockSpecs))
        XCTAssertTrue(mockStorage.calledMethods.contains(.save))
    }

    func testAddLogWhenNoCarsReturnFromStorage() {
        XCTAssertNoThrow(try sut.add(log: .empty, carId: .init()))
        XCTAssertNotNil(mockStorage.receivedDescriptor?.predicate)
        XCTAssertTrue(mockStorage.calledMethods.contains(.fetch))
        XCTAssertFalse(mockStorage.calledMethods.contains(.save))
    }

    func testAddLogWhenCarsReturnFromStorage() {

        mockStorage.fetchResult = .success([.init(make: "",
                                                  model: "",
                                                  year: 0,
                                                  lastPlateNumber: 0,
                                                  milage: 0,
                                                  tankCapacity: 0,
                                                  plateState: .aguascalientes,
                                                  verificationNotificationsEnabled: false)])

        XCTAssertNoThrow(try sut.add(log: .empty, carId: .init()))
        XCTAssertNotNil(mockStorage.receivedDescriptor?.predicate)
        XCTAssertTrue(mockStorage.calledMethods.contains(.fetch))
        XCTAssertTrue(mockStorage.calledMethods.contains(.save))
    }

    func testFetch() throws {
        
        let mockCar = Car(make: "",
                            model: "",
                            year: 0,
                            lastPlateNumber: 0,
                            milage: 0,
                            tankCapacity: 0,
                            plateState: .bajaCalifornia,
                            verificationNotificationsEnabled: false)

        let gasLogs: [GasLog] = [
            .init(date: .now + 5,
                  price: 0,
                  liters: 0,
                  milage: 0,
                  car: mockCar),
            .init(date: .now,
                  price: 0,
                  liters: 0,
                  milage: 0,
                  car: mockCar)
        ]

        mockStorage.fetchResult = .success([.init(make: "",
                                                  model: "",
                                                  year: 0,
                                                  lastPlateNumber: 0,
                                                  milage: 0,
                                                  tankCapacity: 0,
                                                  plateState: .bajaCalifornia,
                                                  verificationNotificationsEnabled: false,
                                                  gasLogs: gasLogs)])

        let car = try sut.fetch(with: FetchDescriptor<Car>()).first

        let transformer = GasLogTransformer()
        // Adapter should return ordered logs by date
        let uiLogs = gasLogs
            .map { transformer.transformToUIModel(from: $0) }
            .sorted { $0.date < $1.date }

        XCTAssertTrue(mockStorage.calledMethods.contains(.fetch))
        XCTAssertEqual(uiLogs, car?.gasLogs)
    }

    func testDelete() throws {
        XCTAssertNoThrow(try sut.delete(carId: .init()))
        XCTAssertTrue(mockStorage.calledMethods.contains(.delete))
    }

}
