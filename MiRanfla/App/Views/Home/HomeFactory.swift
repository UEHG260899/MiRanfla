//
//  HomeFactory.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 17/09/24.
//

import Foundation

enum HomeFactory {
    static func make() -> HomeView {
        let transformer = CarTransformer()
        let adapter = CarAdapter(carTransformer: transformer)
        let viewModel = HomeViewModel(adapter: adapter)
        return HomeView(viewModel: viewModel)
    }
}
