//
//  UIGasLog.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 15/10/24.
//

import Foundation

struct UIGasLog: Identifiable, Hashable {
    let id: UUID
    let date: Date
    let price: Decimal
    let liters: Double
    let milage: Int

    var consumption: Double {
        Double(milage) / liters
    }

    var formatedDate: String {
        formatter.string(from: date)
    }

    private let formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy, HH:mm"
        dateFormatter.locale = Locale(identifier: "es_MX")
        return dateFormatter
    }()

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
    static let empty = UIGasLog(date: .now, price: 10, liters: 10, milage: 10)

    static let mockLogs: [UIGasLog] = [
        UIGasLog(month: 1, price: 150, liters: 15, milage: 15),
        UIGasLog(month: 2, price: 200, liters: 20, milage: 100),
        UIGasLog(month: 3, price: 50, liters: 5, milage: 200),
        UIGasLog(month: 4, price: 230, liters: 23, milage: 5)
    ]
}
#endif
