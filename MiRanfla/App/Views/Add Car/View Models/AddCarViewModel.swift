//
//  AddCarViewModel.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 09/09/24.
//

import Observation

@Observable
class AddCarViewModel {
    
    private let adapter: CarAdapting
    
    var carDataForm: CarDataFormModel = .empty
    var carSpecsForm: CarSpecsFormModel = .empty
    var showError = false

    
    init(adapter: any CarAdapting) {
        self.adapter = adapter
    }
    
    func save(){
        do {
            try adapter.save(data: carDataForm, specs: carSpecsForm)
        } catch {
            showError = true
        }
    }
}
