//
//  GasLogFormData.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 22/10/24.
//

import Foundation

struct GasLogFormData {
    var date: Date
    var price: String
    var liters: String
    var milage: String
}

#if DEBUG
extension GasLogFormData: Equatable {
    static let empty = GasLogFormData(date: .now, price: "", liters: "", milage: "")
}
#endif
