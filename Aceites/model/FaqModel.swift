//
//  faq_model.swift
//  Aceites
//
//  Created by Eddwin Paz on 10/25/18.
//  Copyright © 2018 Esmax. All rights reserved.
//

import Foundation

struct FaqResponse: Decodable {
    let status: Bool?
    let description: String?
    let faq: [Faq]?
}

struct Faq: Decodable {
    let uniqueKey: String?
    let question: String?
    let answer: String?

}
