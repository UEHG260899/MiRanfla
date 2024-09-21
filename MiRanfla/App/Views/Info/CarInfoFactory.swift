//
//  CarInfoFactory.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 20/09/24.
//

import Foundation

enum CarInfoFactory {
    static func make(with car: UICar) -> CarInfoView {
        let adapter = CarAdapter()
        let notificationManager = NotificationsManager()
        let viewModel = CarInfoViewModel(uiCar: car, adapter: adapter, notificationsManager: notificationManager)
        let view = CarInfoView(viewModel: viewModel)
        return view
    }
}
