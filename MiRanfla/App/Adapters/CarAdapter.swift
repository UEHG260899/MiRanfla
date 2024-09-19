//
//  CarAdapter.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 09/09/24.
//

import Foundation
import SwiftData

protocol CarAdapting {
    func save(data: CarDataFormModel, specs: CarSpecsFormModel) throws
    func fetch(with descriptor: FetchDescriptor<Car>) throws -> [UICar]
    func carCount() throws -> Int
}

struct CarAdapter: CarAdapting {
    private let transformer: AddCarModelTransformer
    private let storageManager: SwiftDataManager
    
    init(transformer: AddCarModelTransformer = .init(), storageManager: SwiftDataManager = .init(container: try! .init(for: Car.self))) {
        self.transformer = transformer
        self.storageManager = storageManager
    }

    func save(data: CarDataFormModel, specs: CarSpecsFormModel) throws {
        let car = try transformer.transformToStorageModel(from: data, and: specs)
        try storageManager.save(car)
    }

    func fetch(with descriptor: FetchDescriptor<Car>) throws -> [UICar] {
        let storageCars = try storageManager.fetch(descriptor: descriptor)
        return storageCars.map { transformer.transformToUIModel(from: $0) }
    }

    func carCount() throws -> Int {
        try storageManager.fetch(descriptor: FetchDescriptor<Car>()).count
    }
}
