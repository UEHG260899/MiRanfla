//
//  MockSwiftDataManager.swift
//  MiRanflaTests
//
//  Created by Uriel Hernandez Gonzalez on 10/09/24.
//

@testable import MiRanfla
import SwiftData

class MockSwiftDataManager: SwiftDataManager {
    struct CalledMethods: OptionSet {
        let rawValue: Int

        static let save = CalledMethods(rawValue: 1 << 0)
    }

    var calledMethods: CalledMethods = []

    override func save<T: PersistentModel>(_ object: T) {
        calledMethods.insert(.save)
    }
}
