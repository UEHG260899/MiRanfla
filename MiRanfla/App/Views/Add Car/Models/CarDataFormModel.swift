//
//  CarDataFormModel.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 09/09/24.
//

import Foundation

struct CarDataFormModel {
    var make: String
    var model: String
    var year: String
    var lastPlateNumber: String
}


extension CarDataFormModel {
    static let empty = CarDataFormModel(make: "",
                                        model: "",
                                        year: "",
                                        lastPlateNumber: "")
}
