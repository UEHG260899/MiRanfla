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
                      verificationNotificationsEnabled: carSpecsForm.verificationNotifications)
        
        return car
    }
}
