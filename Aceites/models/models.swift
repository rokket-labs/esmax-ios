//
//  Brand.swift
//  
//
//  Created by Eddwin Paz on 10/19/18.
//

import Foundation

// App menu options
struct AppMenu {
    let id: String
    let name: String
    let imageUrl: String
}

// car types menu options
struct Car {
    let id: String
    let name: String
    let imageUrl: String
    
}

struct Brand {
    let id: String
    let name: String
}

struct CarBrand: Decodable {
    let id: String
    let name: String
}

struct Model: Decodable {
    let id: String
    let name: String
}

struct Motor: Decodable {
    let id: String
    let name: String
}

struct Product: Decodable {
    let id: String
    let name: String
    let title: String
    let ImageUrl: String
}

