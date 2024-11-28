//
//  ViewFactory.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 07/11/24.
//

import SwiftUI

enum ViewFactory {
    enum ViewType {
        case logList([UIGasLog])
        case editGasLog(UIGasLog)
    }

    @ViewBuilder
    static func make(_ type: ViewType) -> some View {
        switch type {
        case .logList(let logs):
            let adapter = CarAdapter()
            let viewModel = GasLogListViewModel(logs: logs, adapter: adapter)
            GasLogsListView(viewModel: viewModel)
        case .editGasLog(let log):
            let adapter = CarAdapter()
            let viewModel = EditGasLogViewModel(log: log, adapter: adapter)
            EditGasLogView(viewModel: viewModel)
        }
    }

}
