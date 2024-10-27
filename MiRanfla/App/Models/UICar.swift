//
//  UICar.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 09/09/24.
//

import Foundation

struct UICar: Hashable {

    private let numberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .decimal
        return formatter
    }()

    let id: UUID
    let make: String
    let model: String
    let year: String
    let lastPlateNumber: String
    let milage: String
    let tankCapacity: String
    let plateState: UIStateInMexico
    let gasLogs: [UIGasLog]
    var verificationNotificationsEnabled: Bool

    var formatedMilage: String {
        guard let numericalMilage = Int(milage),
              let formattedNumber = numberFormatter.string(from: NSNumber(value: numericalMilage)) else {
            return "- km"
        }
        return "\(formattedNumber) km"
    }
}

#if DEBUG
extension UICar {
    static let empty = UICar(id: .init(),
                             make: "",
                             model: "",
                             year: "",
                             lastPlateNumber: "",
                             milage: "",
                             tankCapacity: "",
                             plateState: .cdmx,
                             gasLogs: [UIGasLog](),
                             verificationNotificationsEnabled: false)

    static let previewCar = UICar(id: UUID(),
                                  make: "VW",
                                  model: "Vento",
                                  year: "2015",
                                  lastPlateNumber: "5",
                                  milage: "150000",
                                  tankCapacity: "60",
                                  plateState: .estadoDeMexico,
                                  gasLogs: [.init(date: .now, price: 100, liters: 20, milage: 100)],
                                  verificationNotificationsEnabled: false)
}
#endif
