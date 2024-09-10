//
//  AddCarViewModel.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 09/09/24.
//

import Observation

@Observable
class AddCarViewModel {
    
    private let adapter: AddCarAdapting
    
    var carDataForm: CarDataFormModel = .empty
    var carSpecsForm: CarSpecsFormModel = .empty

    
    init(adapter: any AddCarAdapting) {
        self.adapter = adapter
    }
    
    func save() {
    }
}
