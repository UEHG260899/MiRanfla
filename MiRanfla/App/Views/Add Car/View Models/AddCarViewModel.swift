//
//  AddCarViewModel.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 09/09/24.
//

import Observation
import SwiftUI

@Observable
class AddCarViewModel {

    private let adapter: CarAdapting
    private let notificationsManager: NotificationsManager

    var carDataForm: CarDataFormModel = .empty
    var carSpecsForm: CarSpecsFormModel = .empty {
        didSet {
            guard Constants.requiredVerificationStates.contains(carSpecsForm.plateState) else {
                withAnimation {
                    showVerificationRow = false
                }
                return
            }

            withAnimation {
                showVerificationRow = true
            }
            Task {
                await configureNotifications()
            }
        }
    }
    var showError = false
    var showVerificationRow = true

    init(adapter: any CarAdapting, notificationsManager: NotificationsManager) {
        self.adapter = adapter
        self.notificationsManager = notificationsManager
    }

    func save() async {
        do {
            try adapter.save(data: carDataForm, specs: carSpecsForm)

            if carSpecsForm.verificationNotifications {
                try await scheduleVerificationNotifications()
            }
        } catch {
            showError = true
            notificationsManager.removeNotifications(for: carDataForm.id.uuidString)
        }
    }

    private func scheduleVerificationNotifications() async throws {
        let verificationMonths = VerificationMonths(forPlate: carDataForm.lastPlateNumber)
        let notificationBody = "Tu \(carDataForm.make) \(carDataForm.model) verifica este mes."
        let firstNotification = LocalNotification(id: carDataForm.id.uuidString,
                                                  month: verificationMonths.first.rawValue,
                                                  title: "¡No te olvides de verificar!",
                                                  body: notificationBody)
        let secondNotification = LocalNotification(id: carDataForm.id.uuidString,
                                                   month: verificationMonths.second.rawValue,
                                                   title: "¡No te olvides de verificar!",
                                                   body: notificationBody)
        try await notificationsManager.schedule(firstNotification)
        try await notificationsManager.schedule(secondNotification)
    }

    func configureNotifications() async {
        guard carSpecsForm.verificationNotifications else {
            return
        }

        do {
            let permissionGranted = try await notificationsManager.requestPermissions()

            if !permissionGranted {
                carSpecsForm.verificationNotifications = false
            }
        } catch {
            showError = true
        }
    }
}
