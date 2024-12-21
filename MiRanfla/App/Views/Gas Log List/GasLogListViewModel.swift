//
//  GasLogListViewModel.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 07/11/24.
//

import Foundation
import SwiftData

@Observable
final class GasLogListViewModel {

    enum PresentedScreen: Identifiable {
        case edit(UIGasLog)

        var id: UUID {
            UUID()
        }
    }

    private let adapter: CarAdapting

    var logs: [UIGasLog]
    var presentedScreen: PresentedScreen?
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

    func refreshData(for carId: UUID) {
        do {
            let predicate = #Predicate<Car> { car in
                car.id == carId
            }
            let descriptor = FetchDescriptor(predicate: predicate)
            let updatedCar = try adapter.fetch(with: descriptor).first ?? .empty
            self.logs = updatedCar.gasLogs
        } catch {
            showError = true
        }
    }
}
