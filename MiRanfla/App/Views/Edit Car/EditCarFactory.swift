//
//  EditCarFactory.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 27/09/24.
//

import Foundation

enum EditCarFactory {
    static func make(with car: UICar) -> EditCarView {
        let adapter = CarAdapter()
        let viewModel = EditCarViewModel(car: car, adapter: adapter)
        return EditCarView(viewModel: viewModel)
    }
}
