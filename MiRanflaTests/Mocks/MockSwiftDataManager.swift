//
//  MockSwiftDataManager.swift
//  MiRanflaTests
//
//  Created by Uriel Hernandez Gonzalez on 10/09/24.
//

@testable import MiRanfla
import Foundation
import SwiftData

class MockSwiftDataManager: SwiftDataManager {
    struct CalledMethods: OptionSet {
        let rawValue: Int

        static let save = CalledMethods(rawValue: 1 << 0)
        static let fetch = CalledMethods(rawValue: 1 << 1)
        static let delete = CalledMethods(rawValue: 1 << 2)
    }

    var calledMethods: CalledMethods = []
    var receivedDescriptor: FetchDescriptor<Car>?
    var fetchResult: Result<[Car], Error> = .success([Car]())

    override func save<T: PersistentModel>(_ object: T) {
        calledMethods.insert(.save)
    }

    override func fetch<T: PersistentModel>(descriptor: FetchDescriptor<T>) throws -> [T] {
        calledMethods.insert(.fetch)
        receivedDescriptor = descriptor as? FetchDescriptor<Car>

        switch fetchResult {
        case .success(let cars):
            // swiftlint:disable:next force_cast
            return cars as! [T]
        case .failure(let error):
            throw error
        }
    }

    override func delete<T: PersistentModel>(objectType: T.Type, where predicate: Predicate<T>) throws {
        calledMethods.insert(.delete)
    }
}
