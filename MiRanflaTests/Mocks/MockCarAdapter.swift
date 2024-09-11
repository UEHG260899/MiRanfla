//
//  MockCarAdapter.swift
//  MiRanflaTests
//
//  Created by Uriel Hernandez Gonzalez on 10/09/24.
//

@testable import MiRanfla
import Foundation


final class MockCarAdapter: CarAdapting {
    
    var saveResult: Result<Void, Error> = .success(())
    
    func save(data: CarDataFormModel, specs: CarSpecsFormModel) throws {
        if case let .failure(error) = saveResult {
            throw error
        }
    }
}
