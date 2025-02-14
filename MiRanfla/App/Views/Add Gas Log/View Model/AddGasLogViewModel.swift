//
//  AddGasLogViewModel.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 22/10/24.
//

import Foundation
import Observation

@Observable
final class AddGasLogViewModel {

    private let carId: UUID
    private let adapter: any CarAdapting

    var showError = false
    var gasLogFormData: GasLogFormData

    init(carId: UUID, carAdapter: any CarAdapting) {
        self.carId = carId
        self.adapter = carAdapter
        self.gasLogFormData = GasLogFormData(date: .now, price: "", liters: "", milage: "", id: .init())
    }

    func save() {
        do {
            try adapter.add(log: gasLogFormData, carId: carId)
        } catch {
            showError = true
        }
    }
}
