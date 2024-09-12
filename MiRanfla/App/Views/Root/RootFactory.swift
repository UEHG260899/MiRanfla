//
//  RootFactory.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 11/09/24.
//

import Foundation

enum RootFactory {
    static func make() -> RootView {
        let adapter = CarAdapter()
        let viewModel = RootViewModel(adapter: adapter)
        return RootView(viewModel: viewModel)
    }
}
