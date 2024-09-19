//
//  HomeFactory.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 17/09/24.
//

import Foundation

enum HomeFactory {
    static func make() -> HomeView {
        let transformer = AddCarModelTransformer()
        let adapter = CarAdapter(transformer: transformer)
        let viewModel = HomeViewModel(adapter: adapter)
        return HomeView(viewModel: viewModel)
    }
}
