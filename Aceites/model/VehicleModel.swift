//
//  VehicleModel.swift
//  Aceites
//
//  Created by Eddwin Paz on 10/27/18.
//  Copyright © 2018 Esmax. All rights reserved.
//

import Foundation


struct ModelResponse: Decodable {
    let status: Bool?
    let description: String?
    let model: [VehicleModel]?
}

struct VehicleModel: Decodable {
    let id: String?
    let vehicleModel: String?
}

struct VehicleModelIndex {
    let uniqueId: String?
    let vehicleModel: String?
}

struct ProductJsonResponse {
    let status: Bool?
    let product: [ProductModel]?
}

struct ProductModel {
    let uniqueKey: String?
    let name: String?
    let description: String?
    let image: String?
}

// Product Model
struct ProductJSON: Decodable {
    let status: Bool?
    let product: [ProductJSONDetail]?
}

struct DetailJSON: Decodable {
    let name: String?
    let id: String?
}

struct ProductJSONDetail: Decodable {
    let uniqueKey: String?
    let name: String?
    let engine: [DetailJSON]?
    let description: String?
    let formats: [DetailJSON]?
    let image: String?
    let pdf: String?
}

