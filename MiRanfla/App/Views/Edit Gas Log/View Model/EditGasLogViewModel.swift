//
//  EditGasLogViewModel.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 27/11/24.
//

import Foundation

@Observable
final class EditGasLogViewModel {

    private let adapter: any CarAdapting

    var formData: GasLogFormData
    var showError = false

    init(log: UIGasLog, adapter: any CarAdapting) {
        self.formData = GasLogFormData(from: log)
        self.adapter = adapter
    }

    func save(with carId: UUID) {
        do {
            try adapter.add(log: formData, carId: carId)
        } catch {
            showError = true
        }
    }
}
