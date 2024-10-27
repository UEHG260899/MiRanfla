//
//  Schemas.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 22/10/24.
//

import Foundation
import SwiftData

enum MiRanflaSchemaV1: VersionedSchema {

    static var versionIdentifier: Schema.Version = Schema.Version(1, 0, 0)

    static var models: [any PersistentModel.Type] {
        [Car.self]
    }

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

        init(make: String,
             model: String,
             year: UInt,
             lastPlateNumber: UInt,
             milage: UInt,
             tankCapacity: UInt,
             plateState: StateInMexico,
             verificationNotificationsEnabled: Bool,
             id: UUID = UUID()) {
            self.id = id
            self.make = make
            self.model = model
            self.year = year
            self.lastPlateNumber = lastPlateNumber
            self.milage = milage
            self.tankCapacity = tankCapacity
            self.plateState = plateState
            self.verificationNotificationsEnabled = verificationNotificationsEnabled
        }

    }
}

enum MiRanflaSchemaV2: VersionedSchema {
    static var versionIdentifier: Schema.Version = Schema.Version(2, 0, 0)

    static var models: [any PersistentModel.Type] {
        [Car.self, GasLog.self]
    }

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
        var gasLogs: [GasLog]

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
}
