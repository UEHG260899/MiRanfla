//
//  CarInfoViewModel.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 20/09/24.
//

import Observation

@Observable
final class CarInfoViewModel {

    private let adapter: CarAdapting
    private let notificationsManager: NotificationsManager

    let shouldShowNotificationsRow: Bool
    var uiCar: UICar {
        didSet {
            Task {
                await configureNotifications()
            }
        }
    }
    var showError = false

    init(uiCar: UICar, adapter: any CarAdapting, notificationsManager: NotificationsManager) {
        self.uiCar = uiCar
        self.adapter = adapter
        self.notificationsManager = notificationsManager
        self.shouldShowNotificationsRow = Constants.requiredVerificationStates.contains(uiCar.plateState)
    }

    func configureNotifications() async {
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

            notificationsManager.removeNotifications(for: uiCar.id.uuidString)
        } catch {
            showError = true
        }
    }
}
