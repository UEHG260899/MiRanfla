//
//  EditCarViewModel.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 27/09/24.
//

import Observation

@Observable
final class EditCarViewModel {

    private let adapter: CarAdapting
    var carDataForm: CarDataFormModel
    var carSpecsForm: CarSpecsFormModel
    var showError = false

    init(car: UICar, adapter: any CarAdapting) {
        self.carDataForm = CarDataFormModel(id: car.id,
                                            make: car.make,
                                            model: car.model,
                                            year: car.year,
                                            lastPlateNumber: car.lastPlateNumber)
        self.carSpecsForm = CarSpecsFormModel(milage: car.milage,
                                              tankCapacity: car.tankCapacity,
                                              plateState: car.plateState,
                                              verificationNotifications: car.verificationNotificationsEnabled)
        self.adapter = adapter
    }

    func save() {
        do {
            carSpecsForm.verificationNotifications = Constants
                .requiredVerificationStates
                .contains(carSpecsForm.plateState)
            try adapter.save(data: carDataForm, specs: carSpecsForm)
        } catch {
            showError = true
        }
    }
}
