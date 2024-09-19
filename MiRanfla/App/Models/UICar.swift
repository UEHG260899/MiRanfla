//
//  UICar.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 09/09/24.
//

import Foundation

struct UICar: Hashable {
    let id: UUID
    let make: String
    let model: String
    let year: String
    let lastPlateNumber: String
    let milage: String
    let tankCapacity: String
    let plateState: UIStateInMexico
    let verificationNotificationsEnabled: Bool
}


extension UICar {
    static let empty = UICar(id: .init(),
                             make: "",
                             model: "",
                             year: "", 
                             lastPlateNumber: "",
                             milage: "",
                             tankCapacity: "",
                             plateState: .cdmx,
                             verificationNotificationsEnabled: false)
}
