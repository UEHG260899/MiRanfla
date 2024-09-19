//
//  AddCarModelTransformer.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 09/09/24.
//

import Foundation

struct AddCarModelTransformer {    
    func transformToStorageModel(from carDataForm: CarDataFormModel, and carSpecsForm: CarSpecsFormModel) throws -> Car {
        let car = Car(make: carDataForm.make,
                      model: carDataForm.model,
                      year: try UInt(carDataForm.year, format: .number),
                      lastPlateNumber: try UInt(carDataForm.lastPlateNumber, format: .number),
                      milage: try UInt(carSpecsForm.milage, format: .number),
                      tankCapacity: try UInt(carSpecsForm.tankCapacity, format: .number),
                      plateState: StateInMexico(rawValue: carSpecsForm.plateState.rawValue) ?? .cdmx,
                      verificationNotificationsEnabled: carSpecsForm.verificationNotifications,
                      id: carDataForm.id)
        
        return car
    }

    func transformToUIModel(from car: Car) -> UICar {
        UICar(id: car.id,
              make: car.make,
              model: car.model,
              year: String(describing: car.year),
              lastPlateNumber: String(describing: car.lastPlateNumber),
              milage: String(describing: car.milage),
              tankCapacity: String(describing: car.tankCapacity),
              plateState: UIStateInMexico(rawValue: car.plateState.rawValue) ?? .cdmx,
              verificationNotificationsEnabled: car.verificationNotificationsEnabled)
    }
}
