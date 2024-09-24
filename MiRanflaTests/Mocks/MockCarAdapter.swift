//
//  MockCarAdapter.swift
//  MiRanflaTests
//
//  Created by Uriel Hernandez Gonzalez on 10/09/24.
//

@testable import MiRanfla
import SwiftData

final class MockCarAdapter: CarAdapting {

    var saveResult: Result<Void, Error> = .success(())
    var fetchResult: Result<[UICar], Error> = .success([UICar]())
    var receivedDescriptor: FetchDescriptor<Car>?
    var returningCarsCount = 0

    func save(data: CarDataFormModel, specs: CarSpecsFormModel) throws {
        if case let .failure(error) = saveResult {
            throw error
        }
    }

    func fetch(with descriptor: FetchDescriptor<Car>) throws -> [UICar] {
        receivedDescriptor = descriptor
        switch fetchResult {
        case .success(let cars):
            return cars
        case .failure(let error):
            throw error
        }
    }

    func carCount() throws -> Int {
        returningCarsCount
    }
}
