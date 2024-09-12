//
//  RootViewModel.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 11/09/24.
//

import Foundation
import Observation


@Observable
class RootViewModel {
    
    enum ScreenToShow {
        case noCar
        case home
    }
    
    private let adapter: CarAdapting
    private let notificationsProvider: NotificationsProviding
    
    var screenToShow: ScreenToShow = .noCar
    
    init(adapter: any CarAdapting, notificationsProvider: any NotificationsProviding = NotificationCenter.default) {
        self.adapter = adapter
        self.notificationsProvider = notificationsProvider
        
        do {
            if try adapter.carCount() > 0 {
                screenToShow = .home
                return
            }

            notificationsProvider.addObserver(self, selector: #selector(showHome), name: .NSPersistentStoreRemoteChange, object: nil)
        } catch {}
    }
    
    @objc
    func showHome() {
        // TODO: Support case when user deletes all cars and redirect to no car view
        Task { @MainActor in
            screenToShow = .home
            notificationsProvider.removeObserver(self)
        }
    }
}
