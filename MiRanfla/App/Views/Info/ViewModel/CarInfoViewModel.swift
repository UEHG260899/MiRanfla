//
//  CarInfoViewModel.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 20/09/24.
//

import Foundation
import SwiftData
import Observation

@Observable
final class CarInfoViewModel {

    enum PresentedScreen: Identifiable {
        case editCar
        case addGasLog

        var id: Self {
            self
        }
    }

    private let adapter: CarAdapting
    private let notificationsManager: NotificationsManager

    let shouldShowNotificationsRow: Bool
    var uiCar: UICar
    var showError = false
    var showDeletePrompt = false
    var presentedScreen: PresentedScreen?

    init(uiCar: UICar, adapter: any CarAdapting, notificationsManager: NotificationsManager) {
        self.uiCar = uiCar
        self.adapter = adapter
        self.notificationsManager = notificationsManager
        self.shouldShowNotificationsRow = Constants.requiredVerificationStates.contains(uiCar.plateState)
    }

    func manageNotifications(toggleState: Bool) async {
        guard toggleState else {
            notificationsManager.removeNotifications(for: uiCar.id.uuidString)
            return
        }

        do {
            let permissionsGranted = try await notificationsManager.requestPermissions()

            if !permissionsGranted {
                uiCar.verificationNotificationsEnabled = false
                return
            }

            if uiCar.verificationNotificationsEnabled {
                let verificationMonths = VerificationMonths(forPlate: uiCar.lastPlateNumber)
                let firstNotification = LocalNotification(id: uiCar.id.uuidString,
                                                          month: verificationMonths.first.rawValue,
                                                          title: "¡No te olvides de verificar!",
                                                          body: "Tu \(uiCar.make) \(uiCar.model) verifica este mes.")
                let secondNotification = LocalNotification(id: uiCar.id.uuidString,
                                                          month: verificationMonths.second.rawValue,
                                                          title: "¡No te olvides de verificar!",
                                                          body: "Tu \(uiCar.make) \(uiCar.model) verifica este mes.")
                try await notificationsManager.schedule(firstNotification)
                try await notificationsManager.schedule(secondNotification)
                return
            }

        } catch {
            showError = true
        }
    }

    func deleteCar() {
        do {
            try adapter.delete(carId: uiCar.id)
        } catch {
            showError = true
        }
    }

    func refreshData() {
        do {
            let id = uiCar.id
            let predicate = #Predicate<Car> { car in
                car.id == id
            }
            let descriptor = FetchDescriptor(predicate: predicate)
            let updatedCar = try adapter.fetch(with: descriptor).first ?? .empty
            uiCar = updatedCar
        } catch {
            showError = true
        }
    }
}
