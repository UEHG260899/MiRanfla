//
//  GasLogListViewModel.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 07/11/24.
//

import Foundation

@Observable
final class GasLogListViewModel {

    private let adapter: CarAdapting

    var logs: [UIGasLog]
    var showError = false

    init(logs: [UIGasLog], adapter: any CarAdapting) {
        self.logs = logs
        self.adapter = adapter
    }

    func delete(_ log: UIGasLog) {
        do {
            try adapter.delete(logId: log.id)
            logs.removeAll(where: { $0.id == log.id })
        } catch {
            showError = true
        }
    }
}
