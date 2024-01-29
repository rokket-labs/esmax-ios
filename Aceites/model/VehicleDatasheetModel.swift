//
//  DatasheetModel.swift
//  Aceites
//
//  Created by Eddwin Paz on 10/27/18.
//  Copyright © 2018 Esmax. All rights reserved.
//

import Foundation


struct DatasheetResponse: Decodable {
    let status: Bool?
    let description: String?
    let datasheet: [Datasheet]?
}

struct Datasheet: Decodable {
    let uniqueId: String?
    let vehicleCategoryName: String?
    let vehicleManufactureBrand: String?
    let vehicleModel: String?
    let vehicleType: String?
    let title: String?
    let value: String?
    
}
