//
//  CarSpecsFormModel.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 09/09/24.
//

import Foundation

struct CarSpecsFormModel {
    var milage: String
    var tankCapacity: String
    var plateState: UIStateInMexico
    var verificationNotifications: Bool
}


extension CarSpecsFormModel {
    static let empty = CarSpecsFormModel(milage: "",
                                     tankCapacity: "",
                                     plateState: .cdmx,
                                     verificationNotifications: false)
}
