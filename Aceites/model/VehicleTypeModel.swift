//
//  VehicleTypeModel.swift
//  Aceites
//
//  Created by Eddwin Paz on 10/27/18.
//  Copyright © 2018 Esmax. All rights reserved.
//

import Foundation

struct VehicleTypeResponse: Decodable {
    let status: Bool?
    let description: String?
    let type: [VehicleType]?
}

struct VehicleType: Decodable {
    let id: String?
    let type: String?
    
}
