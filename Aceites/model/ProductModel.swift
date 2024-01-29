//
//  ProductModel.swift
//  Aceites
//
//  Created by Eddwin Paz on 10/28/18.
//  Copyright © 2018 Esmax. All rights reserved.
//

import Foundation

// This are real Product response Decodable objects
struct ProductResponse: Codable {
    let status: Bool?
    let product: [ProductObject]?
}

struct DetailArray: Codable {
    let name: String?
    let id: Int?
}

struct EquivalentArray: Codable {
    let name: String?
    let product: String?
}

struct ProductObject: Codable {
    
    let uniqueKey: String?
    let name: String?
    let engine: DetailArray?
    let description: String?
    let formats: [DetailArray]?
    let uses: [DetailArray]?
    let image: String?
    let pdf: String?
    let equivalent: [EquivalentArray]?
    
    init(uniqueKey: String, name: String, engine:DetailArray, description: String, formats: [DetailArray], uses: [DetailArray], image: String,
         pdf: String, equivalent: [EquivalentArray]){
        
            self.uniqueKey = uniqueKey
            self.name = name
            self.engine = engine
            self.description = description
            self.formats = formats
            self.uses = uses
            self.image = image
            self.pdf = pdf
            self.equivalent = equivalent
    }
}

// TODO: Delete this after final change
struct ProductItem {
    let productName: String
    let productDescription: String
    let productGuide: [String]
    let productFormat: [String]
    let productImage: String
}
