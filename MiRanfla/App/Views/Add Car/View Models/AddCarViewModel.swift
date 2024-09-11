//
//  AddCarViewModel.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 09/09/24.
//

import Observation
import SwiftUI

@Observable
class AddCarViewModel {
    
    private let adapter: CarAdapting
    
    var carDataForm: CarDataFormModel = .empty
    var carSpecsForm: CarSpecsFormModel = .empty {
        didSet {
            guard Constants.requiredVerificationStates.contains(carSpecsForm.plateState) else {
                withAnimation {
                    showVerificationRow = false
                }
                return
            }
            
            withAnimation {
                showVerificationRow = true
            }
        }
    }
    var showError = false
    var showVerificationRow = false

    
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
