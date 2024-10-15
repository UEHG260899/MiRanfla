//
//  PreviewCarAdapter.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 26/09/24.
//

import Foundation
import SwiftData

#if DEBUG
struct PreviewCarAdapter: CarAdapting {

    var cars = [
        UICar(id: .init(),
              make: "Toyota",
              model: "Avanza",
              year: "2024",
              lastPlateNumber: "2",
              milage: "1000",
              tankCapacity: "60",
              plateState: .estadoDeMexico,
              verificationNotificationsEnabled: false),
        UICar(id: .init(),
              make: "VW",
              model: "Vento",
              year: "2015",
              lastPlateNumber: "2",
              milage: "110000",
              tankCapacity: "60",
              plateState: .nuevoLeon,
              verificationNotificationsEnabled: false)
    ]

    func save(data: CarDataFormModel, specs: CarSpecsFormModel) throws {
    }

    func fetch(with descriptor: FetchDescriptor<Car>) throws -> [UICar] {
        cars
    }

    func delete(carId: UUID) throws {
    }

    func carCount() throws -> Int {
        cars.count
    }
}
#endif
