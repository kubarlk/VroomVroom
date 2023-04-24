//
//  CarLogo.swift
//  
//
//  Created by Kirill Kubarskiy on 20.04.23.
//

import Fluent
import Vapor

final class CarLogo: Model, Content {
    
    static var schema: String = "logo"
    
    @ID
    var id: UUID?
    @Field(key: "brand") var brand : String
    @Field(key: "imageUrl") var imageUrl: String
    
    init() {}
    
    init(id: UUID? = nil, brand: String, imageUrl: String) {
        self.id = id
        self.brand = brand
        self.imageUrl = imageUrl
    }
}
