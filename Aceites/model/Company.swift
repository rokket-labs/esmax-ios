//
//  Company.swift
//  Aceites
//
//  Created by Eddwin Paz on 2/3/19.
//  Copyright © 2019 Esmax. All rights reserved.
//

import Foundation


//{
//    status: true,
//    company: [
//    {
//    id: 1,
//    unique_key: "585214f6-d112-4ebf-b509-c580daf92d60",
//    company: "Shell"
//    },
//    {
//    id: 2,
//    unique_key: "faf3477f-f0bd-44e1-ad98-b3d85bd2f7b4",
//    company: "Mobil"
//    }
//    ]
//}

struct CompanyResponse: Decodable {
    let status: Bool?
    let companyProduct: [CompanyObject]?
}

struct CompanyObject: Decodable {
    let id: Int?
    let uniqueKey: String?
    let name: String?
    let product: ProductObject?
}
