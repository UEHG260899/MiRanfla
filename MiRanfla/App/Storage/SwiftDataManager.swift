//
//  SwiftDataManager.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 02/09/24.
//

import Foundation
import SwiftData

struct SwiftDataManager {
    
    private let container: ModelContainer
    private let context: ModelContext
    
    init(container: ModelContainer) {
        self.container = container
        self.context = ModelContext(container)
    }

    func save<T: PersistentModel>(_ object: T) {
        context.insert(object)
    }

    func fetch<T: PersistentModel>(descriptor: FetchDescriptor<T>) throws -> [T] {
        try context.fetch(descriptor)
    }
    
    func delete<T: PersistentModel>(object: T) {
        context.delete(object)
    }

}
