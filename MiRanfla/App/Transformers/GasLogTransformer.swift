//
//  GasLogTransformer.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 24/10/24.
//

import Foundation

struct GasLogTransformer {

    func transformToStorageModel(from uiLog: GasLogFormData, associatedCar car: Car) -> GasLog {
        GasLog(date: uiLog.date,
               price: Decimal(string: uiLog.price) ?? 0,
               liters: Double(uiLog.liters) ?? 0,
               milage: Int(uiLog.milage) ?? 0,
               car: car,
               id: uiLog.id)
    }

    func transformToUIModel(from storageLog: GasLog) -> UIGasLog {
        UIGasLog(date: storageLog.date,
                 price: storageLog.price,
                 liters: storageLog.liters,
                 milage: storageLog.milage,
                 id: storageLog.id)
    }
}
