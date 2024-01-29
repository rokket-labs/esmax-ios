//
//  manufacture_model.swift
//  Aceites
//
//  Created by Eddwin Paz on 10/27/18.
//  Copyright © 2018 Esmax. All rights reserved.
//

import Foundation

struct ManufactureResponse: Decodable {
    let status: Bool?
    let description: String?
    let manufacture: [VehicleManufacture]?
}

struct VehicleManufacture: Decodable {
    let id: String?
    let brand: String?
    
}
