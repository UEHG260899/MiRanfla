//
//  AddCarAdapter.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 09/09/24.
//

import Foundation

protocol AddCarAdapting {
    func save(_ car: Any)
}

struct AddCarAdapter: AddCarAdapting {
    private let storageManager: SwiftDataManager
    
    init(storageManager: SwiftDataManager) {
        self.storageManager = storageManager
    }

    func save(_ car: Any) {
        
    }
}
