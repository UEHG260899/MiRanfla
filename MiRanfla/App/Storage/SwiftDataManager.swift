//
//  SwiftDataManager.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 02/09/24.
//

import Foundation
import SwiftData

class SwiftDataManager {
    
    private let container: ModelContainer
    private let context: ModelContext
    
    init(container: ModelContainer) {
        self.container = container
        self.context = ModelContext(container)
    }

    func save<T: PersistentModel>(_ object: T) throws {
        context.insert(object)
        try context.save()
    }

    func fetch<T: PersistentModel>(descriptor: FetchDescriptor<T>) throws -> [T] {
        try context.fetch(descriptor)
    }
    
    func delete<T: PersistentModel>(object: T) throws {
        context.delete(object)
        try context.save()
    }

}
