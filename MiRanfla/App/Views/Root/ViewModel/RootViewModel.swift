//
//  RootViewModel.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 11/09/24.
//

import Foundation
import Observation

@Observable
final class RootViewModel {

    enum ScreenToShow {
        case noCar
        case home
    }

    private let adapter: CarAdapting
    private let notificationsObserver: NotificationsObserving

    var screenToShow: ScreenToShow = .noCar

    init(adapter: any CarAdapting, notificationsObserver: any NotificationsObserving = NotificationCenter.default) {
        self.adapter = adapter
        self.notificationsObserver = notificationsObserver

        do {
            if try adapter.carCount() > 0 {
                screenToShow = .home
                return
            }

            notificationsObserver.addObserver(self,
                                              selector: #selector(showHome),
                                              name: .NSPersistentStoreRemoteChange, object: nil)

            notificationsObserver.addObserver(self,
                                              selector: #selector(showNoCarView),
                                              name: .allCarsDeletedNotification,
                                              object: nil)
        } catch {}
    }

    @objc
    func showHome() {
        Task { @MainActor in
            screenToShow = .home
            notificationsObserver.removeObserver(self, name: .NSPersistentStoreRemoteChange, object: nil)
        }
    }

    @objc
    func showNoCarView() {
        Task { @MainActor in
            screenToShow = .noCar
        }
    }
}
