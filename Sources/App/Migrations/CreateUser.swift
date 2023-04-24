//
//  CreateUser.swift
//  
//
//  Created by Kirill Kubarskiy on 12.04.23.
//

import Fluent
import Vapor

struct CreateUser: AsyncMigration {
    
    func prepare(on database: FluentKit.Database) async throws {
        let schema = database.schema("users")
            .id()
            .field("name", .string, .required)
            .field("login", .string, .required)
            .unique(on: "login")
            .field("password", .string, .required)
            .field("role", .string, .required)
            .field("profilePic", .string)
        try await schema.create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("users").delete()
    }
    
}
