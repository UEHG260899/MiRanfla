//
//  AddCarFactory.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 09/09/24.
//

import Foundation

enum AddCarFactory {
    static func make() -> AddCarView {
        let adapter = AddCarAdapter()
        let viewModel = AddCarViewModel(adapter: adapter)
        return AddCarView(viewModel: viewModel)
    }
}
