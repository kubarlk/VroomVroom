//
//  Car.swift
//  
//
//  Created by Kirill Kubarskiy on 12.04.23.
//

import Fluent
import Vapor

final class Car: Model, Content {
    
    static var schema: String = "cars"
    
    @ID
    var id: UUID?
    
    @Field(key: "brand") var brand : String
    @Field(key: "model") var model : String
    @Field(key: "type") var type : String
    @Field(key: "year") var year: String
    @Field(key: "typeOfFuel") var typeOfFuel: String
    @Field(key: "engineCapacity") var engineCapacity: Double
    @Field(key: "price") var price : Int
    @Field(key: "imageUrl") var imageUrl: String
    @Field(key: "detailedImages") var detailedImages: [String]
    @Field(key: "videoUrl") var videoUrl: String
    @Field(key: "country") var country: String
    @Field(key: "isBooking") var isBooking: Bool
    @Field(key: "carClass") var carClass: String
    
    init() {}
    
    init(id: UUID? = nil, brand: String, model: String, type: String, year: String, typeOfFuel: String, engineCapacity: Double, price: Int, imageUrl: String, detailedImages: [String], videoUrl: String, country: String, isBooking: Bool, carClass: String) {
        self.id = id
        self.brand = brand
        self.model = model
        self.type = type
        self.year = year
        self.typeOfFuel = typeOfFuel
        self.engineCapacity = engineCapacity
        self.price = price
        self.imageUrl = imageUrl
        self.detailedImages = detailedImages
        self.videoUrl = videoUrl
        self.country = country
        self.isBooking = isBooking
        self.carClass = carClass
    }
}
