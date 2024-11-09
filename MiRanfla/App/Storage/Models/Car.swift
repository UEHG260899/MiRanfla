//
//  Car.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 02/09/24.
//

import Foundation
import SwiftData

@Model
final class Car {
    @Attribute(.unique)
    var id: UUID
    var make: String
    var model: String
    var year: UInt
    var lastPlateNumber: UInt
    var milage: UInt
    var tankCapacity: UInt
    var plateState: StateInMexico
    var verificationNotificationsEnabled: Bool

    @Relationship(deleteRule: .cascade, inverse: \GasLog.car)
    var gasLogs: [GasLog]?

    init(make: String,
         model: String,
         year: UInt,
         lastPlateNumber: UInt,
         milage: UInt,
         tankCapacity: UInt,
         plateState: StateInMexico,
         verificationNotificationsEnabled: Bool,
         gasLogs: [GasLog] = [GasLog](),
         id: UUID = UUID()) {
        self.id = id
        self.make = make
        self.model = model
        self.year = year
        self.lastPlateNumber = lastPlateNumber
        self.milage = milage
        self.tankCapacity = tankCapacity
        self.plateState = plateState
        self.gasLogs = gasLogs
        self.verificationNotificationsEnabled = verificationNotificationsEnabled
    }

}
