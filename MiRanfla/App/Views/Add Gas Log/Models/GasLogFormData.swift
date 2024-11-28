//
//  GasLogFormData.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 22/10/24.
//

import Foundation

struct GasLogFormData {
    let id: UUID
    var date: Date
    var price: String
    var liters: String
    var milage: String

    
    init(date: Date, price: String, liters: String, milage: String, id: UUID = UUID()) {
        self.id = id
        self.date = date
        self.price = price
        self.liters = liters
        self.milage = milage
    }
    
    init(from uiGasLog: UIGasLog) {
        self.id = uiGasLog.id
        self.date = uiGasLog.date
        self.price = String(describing: uiGasLog.price)
        self.liters = String(describing: uiGasLog.liters)
        self.milage = String(describing: uiGasLog.milage)
    }
}

#if DEBUG
extension GasLogFormData: Equatable {
    static let empty = GasLogFormData(date: .now, price: "", liters: "", milage: "")
}
#endif
