//
//  CarsController.swift
//  
//
//  Created by Kirill Kubarskiy on 12.04.23.
//

import Fluent
import Vapor

struct CarsController: RouteCollection {
    
    func boot(routes: Vapor.RoutesBuilder) throws {
        let carsGroup = routes.grouped("cars")
        carsGroup.get(use: getAllHandler)
        carsGroup.get(":carID", use: getHandler)
        carsGroup.post(use: createHandler)
        carsGroup.delete(":carID", use: deleteHandler)
        carsGroup.delete(use: deleteAllHandler)
        carsGroup.put(":carID", use: updateHandler)
//        let basicMW = User.authenticator()
//        let guardMW = User.guardMiddleware()
//        let protected = carsGroup.grouped(basicMW, guardMW)
//        protected.post(use: createHandler)
//        protected.delete(":carID", use: deleteHandler)
//        protected.put(":carID", use: updateHandler)
    }
    
    func createHandler(_ req: Request) async throws -> Car {
        guard let car = try? req.content.decode(Car.self) else {
            throw Abort(.custom(code: 499, reasonPhrase: "Не получилось декодировать контент в модель Car"))
        }
        try await car.save(on: req.db)
        return car
    }
    
    func getAllHandler(_ req: Request) async throws -> [Car] {
        let cars = try await Car.query(on: req.db).all()
        return cars
    }
    
    func getHandler(_ req: Request) async throws -> Car {
        guard let car = try await Car.find(req.parameters.get("carID"), on: req.db) else {
            throw Abort(.notFound)
        }
        return car
    }
    
    func deleteHandler(_ req: Request) async throws -> HTTPStatus {
        guard let car = try await Car.find(req.parameters.get("carID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await car.delete(on: req.db)
        return .ok
    }
    
    func deleteAllHandler(_ req: Request) async throws -> HTTPStatus {
        try await Car.query(on: req.db).delete()
        return .ok
    }

    
    func updateHandler(_ req: Request) async throws -> Car {
        guard let car = try await Car.find(req.parameters.get("carID"), on: req.db) else {
            throw Abort(.notFound)
        }
        let updatedCar = try req.content.decode(Car.self)
        car.brand = updatedCar.brand
        car.model = updatedCar.model
        car.type = updatedCar.type
        car.typeOfFuel = updatedCar.typeOfFuel
        car.price = updatedCar.price
        car.imageUrl = updatedCar.imageUrl
        car.engineCapacity = updatedCar.engineCapacity
        car.year = updatedCar.year
        car.detailedImages = updatedCar.detailedImages
        car.country = updatedCar.country
        car.isBooking = updatedCar.isBooking
        car.videoUrl = updatedCar.videoUrl
        try await car.save(on: req.db)
        return car
    }
}
            
                        
                     
                        
