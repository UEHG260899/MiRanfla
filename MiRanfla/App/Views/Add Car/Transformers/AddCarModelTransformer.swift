//
//  AddCarModelTransformer.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 09/09/24.
//

import Foundation

struct AddCarModelTransformer {
    private let carDataForm: CarDataFormModel
    private let carSpecsForm: CarSpecsFormModel
    
    init(carDataForm: CarDataFormModel, carSpecsForm: CarSpecsFormModel) {
        self.carDataForm = carDataForm
        self.carSpecsForm = carSpecsForm
    }
    
    func transformToStorageModel() throws -> Car {
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
