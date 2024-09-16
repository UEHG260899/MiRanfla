//
//  CarDataFormModel.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 09/09/24.
//

import Foundation

struct CarDataFormModel {
    let id: UUID
    var make: String
    var model: String
    var year: String
    var lastPlateNumber: String
}


extension CarDataFormModel {
    static let empty = CarDataFormModel(id: UUID(),
                                        make: "",
                                        model: "",
                                        year: "",
                                        lastPlateNumber: "")
}
