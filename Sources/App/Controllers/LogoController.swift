//
//  LogoController.swift
//  
//
//  Created by Kirill Kubarskiy on 20.04.23.
//

import Fluent
import Vapor

struct LogoController: RouteCollection {
    
    func boot(routes: Vapor.RoutesBuilder) throws {
        let carsGroup = routes.grouped("logo")
        carsGroup.get(use: getAllHandler)
        carsGroup.get(":logoID", use: getHandler)
        carsGroup.post(use: createHandler)
        carsGroup.delete(":logoID", use: deleteHandler)
        carsGroup.delete(use: deleteAllHandler)
        carsGroup.put(":logoID", use: updateHandler)
//        let basicMW = User.authenticator()
//        let guardMW = User.guardMiddleware()
//        let protected = carsGroup.grouped(basicMW, guardMW)
//        protected.post(use: createHandler)
//        protected.delete(":carID", use: deleteHandler)
//        protected.put(":carID", use: updateHandler)
    }
    
    func createHandler(_ req: Request) async throws -> CarLogo {
        guard let logo = try? req.content.decode(CarLogo.self) else {
            throw Abort(.custom(code: 499, reasonPhrase: "Не получилось декодировать контент в модель Car"))
        }
        try await logo.save(on: req.db)
        return logo
    }
    
    func getAllHandler(_ req: Request) async throws -> [CarLogo] {
        let logo = try await CarLogo.query(on: req.db).all()
        return logo
    }
    
    func getHandler(_ req: Request) async throws -> CarLogo {
        guard let logo = try await CarLogo.find(req.parameters.get("logoID"), on: req.db) else {
            throw Abort(.notFound)
        }
        return logo
    }
    
    func deleteHandler(_ req: Request) async throws -> HTTPStatus {
        guard let logo = try await CarLogo.find(req.parameters.get("logoID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await logo.delete(on: req.db)
        return .ok
    }
    
    func deleteAllHandler(_ req: Request) async throws -> HTTPStatus {
        try await CarLogo.query(on: req.db).delete()
        return .ok
    }

    
    func updateHandler(_ req: Request) async throws -> CarLogo {
        guard let logo = try await CarLogo.find(req.parameters.get("logoID"), on: req.db) else {
            throw Abort(.notFound)
        }
        let updatedLogo = try req.content.decode(CarLogo.self)
        logo.brand = updatedLogo.brand
        logo.imageUrl = updatedLogo.imageUrl
        try await logo.save(on: req.db)
        return logo
    }
}
