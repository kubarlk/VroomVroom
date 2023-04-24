//
//  CreateCarLogo.swift
//  
//
//  Created by Kirill Kubarskiy on 20.04.23.
//

import Fluent
import Vapor

struct CreateCarLogo: AsyncMigration {
    func prepare(on database: FluentKit.Database) async throws {
        let  schema = database.schema("logo")
            .id()
            .field("brand", .string, .required)
            .field("imageUrl", .string , .required)
        try await schema.create()
    }
    
    func revert(on database: FluentKit.Database) async throws {
        try await database.schema("logo").delete()
    }
}
