//
//  GasLog.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 22/10/24.
//

import Foundation
import SwiftData

@Model
final class GasLog {
    @Attribute(.unique)
    var id: UUID
    var date: Date
    var price: Decimal
    var liters: Double
    var milage: Int
    var car: Car

    init(date: Date, price: Decimal, liters: Double, milage: Int, car: Car, id: UUID = UUID()) {
        self.id = id
        self.date = date
        self.price = price
        self.liters = liters
        self.milage = milage
        self.car = car
    }
}
