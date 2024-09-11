//
//  CarFormModels+Equatable.swift
//  MiRanflaTests
//
//  Created by Uriel Hernandez Gonzalez on 10/09/24.
//

@testable import MiRanfla
import Foundation

extension CarDataFormModel: Equatable {
    public static func == (lhs: CarDataFormModel, rhs: CarDataFormModel) -> Bool {
        return lhs.make == rhs.make && 
        lhs.model == rhs.model &&
        lhs.year == rhs.year &&
        lhs.lastPlateNumber == rhs.lastPlateNumber
    }
}

extension CarSpecsFormModel: Equatable {
    public static func == (lhs: CarSpecsFormModel, rhs: CarSpecsFormModel) -> Bool {
        return lhs.milage == rhs.milage &&
        lhs.tankCapacity == rhs.tankCapacity &&
        lhs.plateState.rawValue == rhs.plateState.rawValue &&
        lhs.verificationNotifications == rhs.verificationNotifications
    }
}
