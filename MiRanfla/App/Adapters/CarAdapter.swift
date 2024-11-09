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
    func add(log: GasLogFormData, carId: UUID) throws
    func fetch(with descriptor: FetchDescriptor<Car>) throws -> [UICar]
    func delete(carId: UUID) throws
    func delete(logId: UUID) throws
    func carCount() throws -> Int
}

struct CarAdapter: CarAdapting {
    private let carTransformer: CarTransformer
    private let gasLogTransformer: GasLogTransformer
    private let storageManager: SwiftDataManager

    init(carTransformer: CarTransformer = .init(),
         gasLogTransformer: GasLogTransformer = .init(),
         // swiftlint:disable:next force_try
         storageManager: SwiftDataManager = .init(container: try! .init(for: Car.self, migrationPlan: MiRanflaMigrationPlan.self))) {
        // swiftlint:disable:previous line_length
        self.carTransformer = carTransformer
        self.gasLogTransformer = gasLogTransformer
        self.storageManager = storageManager
    }

    func save(data: CarDataFormModel, specs: CarSpecsFormModel) throws {
        let car = try carTransformer.transformToStorageModel(from: data, and: specs)
        try storageManager.save(car)
    }

    func add(log: GasLogFormData, carId: UUID) throws {
        let predicate = #Predicate<Car> { car in
            car.id == carId
        }
        let descriptor = FetchDescriptor<Car>(predicate: predicate)

        if let car = try storageManager.fetch(descriptor: descriptor).first {
            let gasLog = gasLogTransformer.transformToStorageModel(from: log, associatedCar: car)
            car.gasLogs?.append(gasLog)
            try storageManager.save(car)
        }
    }

    func fetch(with descriptor: FetchDescriptor<Car>) throws -> [UICar] {
        let storageCars = try storageManager.fetch(descriptor: descriptor)
        return storageCars.map { storageCar in
            let uiLogs = storageCar.gasLogs?.map { gasLogTransformer.transformToUIModel(from: $0) }
                .sorted { $0.date < $1.date }
            return carTransformer.transformToUIModel(from: storageCar, gasLogs: uiLogs ?? [])
        }
    }

    func delete(carId: UUID) throws {
        let predicate = #Predicate<Car> { car in
            car.id == carId
        }
        try storageManager.delete(objectType: Car.self, where: predicate)
    }

    func delete(logId: UUID) throws {
        let predicate = #Predicate<GasLog>{ log in
            log.id == logId
        }
        try storageManager.delete(objectType: GasLog.self, where: predicate)
    }

    func carCount() throws -> Int {
        try storageManager.fetch(descriptor: FetchDescriptor<Car>()).count
    }
}
