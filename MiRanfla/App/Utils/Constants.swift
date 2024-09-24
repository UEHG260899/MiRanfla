//
//  Constants.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 10/09/24.
//

import Foundation

// swiftlint:disable:next identifier_name
func VerificationMonths(forPlate plate: String) -> (first: VerificationMonth, second: VerificationMonth) {
    guard let months = Constants.verificationMonths[plate] else {
        return (.january, .january)
    }

    return months
}

enum Constants {
    static let requiredVerificationStates: Set<UIStateInMexico> = [.cdmx, .estadoDeMexico, .michoacan, .guanajuato]

    static let verificationMonths: [String: (VerificationMonth, VerificationMonth)] = [
        "5": (.january, .july),
        "6": (.january, .july),
        "7": (.february, .august),
        "8": (.february, .august),
        "3": (.march, .september),
        "4": (.march, .september),
        "1": (.april, .october),
        "2": (.april, .october),
        "9": (.may, .december),
        "0": (.may, .december)
    ]
}
