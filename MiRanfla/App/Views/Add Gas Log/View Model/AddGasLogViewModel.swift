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
    var gasLogFormData: GasLogFormData = .empty
    var showError = false

    init(carId: UUID, carAdapter: any CarAdapting) {
        self.carId = carId
        self.adapter = carAdapter
    }

    func save() {
        do {
            try adapter.add(log: gasLogFormData, carId: carId)
        } catch {
            showError = true
        }
    }
}
