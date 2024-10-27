//
//  AddGasLogFactory.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 22/10/24.
//

import Foundation

enum AddGasLogFactory {
    static func make(carId: UUID) -> AddGasLogView {
        let adapter = CarAdapter()
        let viewModel = AddGasLogViewModel(carId: carId, carAdapter: adapter)
        let view = AddGasLogView(viewModel: viewModel)
        return view
    }
}
