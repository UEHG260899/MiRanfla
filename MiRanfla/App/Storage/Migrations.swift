//
//  Migrations.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 22/10/24.
//

import SwiftData

enum MiRanflaMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [MiRanflaSchemaV1.self, MiRanflaSchemaV2.self]
    }
    
    static var stages: [MigrationStage] {
        [migrateV1toV2]
    }

    static let migrateV1toV2 = MigrationStage.lightweight(fromVersion: MiRanflaSchemaV1.self, toVersion: MiRanflaSchemaV2.self)
}
