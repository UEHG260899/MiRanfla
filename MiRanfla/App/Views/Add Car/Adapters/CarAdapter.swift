//
//  CarAdapter.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 09/09/24.
//

import Foundation

protocol CarAdapting {
    func save(data: CarDataFormModel, specs: CarSpecsFormModel) throws
}

struct CarAdapter: CarAdapting {
    private let transformer: AddCarModelTransformer
    private let storageManager: SwiftDataManager
    
    init(transformer: AddCarModelTransformer, storageManager: SwiftDataManager = .init(container: try! .init(for: Car.self))) {
        self.transformer = transformer
        self.storageManager = storageManager
    }

    func save(data: CarDataFormModel, specs: CarSpecsFormModel) throws {
        let car = try transformer.transformToStorageModel(from: data, and: specs)
        storageManager.save(car)
    }
}
