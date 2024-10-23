//
//  UIGasLog.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 15/10/24.
//

import Foundation

struct UIGasLog: Identifiable {
    let id: UUID
    let date: Date
    let price: Decimal
    let liters: Double
    let milage: Int
    var consumption: Double {
        Double(milage) / liters
    }

    // Graph init
    init(month: Int, price: Decimal, liters: Double, milage: Int, id: UUID = UUID()) {
        self.id = id
        self.price = price
        self.liters = liters
        self.milage = milage
        let calendar = Calendar.autoupdatingCurrent
        self.date = calendar.date(from: DateComponents(month: month))!
    }

    init(date: Date, price: Decimal, liters: Double, milage: Int, id: UUID = UUID()) {
        self.id = id
        self.date = date
        self.price = price
        self.liters = liters
        self.milage = milage
    }
}

#if DEBUG
extension UIGasLog {
    static let mockLogs: [UIGasLog] = [
        UIGasLog(month: 1, price: 150, liters: 15, milage: 15),
        UIGasLog(month: 2, price: 200, liters: 20, milage: 100),
        UIGasLog(month: 3, price: 50, liters: 5, milage: 200),
        UIGasLog(month: 4, price: 230, liters: 23, milage: 5)
    ]
}
#endif
