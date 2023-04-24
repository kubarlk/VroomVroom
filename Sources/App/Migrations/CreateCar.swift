//
//  CreateCar.swift
//  
//
//  Created by Kirill Kubarskiy on 12.04.23.
//

import Fluent
import Vapor
//MARK: CreateCar
struct CreateCar: AsyncMigration {
    func prepare(on database: FluentKit.Database) async throws {
        let  schema = database.schema("cars")
            .id()
            .field("brand", .string, .required)
            .field("model", .string, .required)
            .field("type", .string, .required)
            .field("year", .string, .required)
            .field("typeOfFuel", .string, .required)
            .field("engineCapacity", .double, .required)
            .field("price", .int, .required)
            .field("imageUrl", .string , .required)
            .field("detailedImages", .array(of: .string), .required)
            .field("videoUrl", .string , .required)
            .field("country", .string , .required)
            .field("isBooking", .bool, .required)
            .field("carClass", .string, .required)
        try await schema.create()
    }
    
    func revert(on database: FluentKit.Database) async throws {
        try await database.schema("cars").delete()
    }
}
