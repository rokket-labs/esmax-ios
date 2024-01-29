//
//  Favorites.swift
//  Aceites
//
//  Created by Eddwin Paz on 1/21/19.
//  Copyright © 2019 Esmax. All rights reserved.
//

import Foundation

func getPlist(withName name: String) -> [String]?
{
    if  let path = Bundle.main.path(forResource: name, ofType: "plist"),
        let xml = FileManager.default.contents(atPath: path)
    {
        print(path)
        return (try? PropertyListSerialization.propertyList(from: xml, options: .mutableContainersAndLeaves, format: nil)) as? [String]
    }
    
    return nil
}

func getFavorites() -> [ProductObject]?{
    
    let placeData = UserDefaults.standard.data(forKey: "favorites")
    if placeData == nil {
        return nil
    }
    let placeArray = try! JSONDecoder().decode([ProductObject].self, from: placeData!)
    return placeArray
    
}


//class Place: Codable {
//    var latitude: Double
//    var longitude: Double
//
//    init(lat : Double, long: Double) {
//        self.latitude = lat
//        self.longitude = long
//    }
//
//    public static func savePlaces(){
//        var placeArray = [Place]()
//        let place1 = Place(lat: 10.0, long: 12.0)
//        let place2 = Place(lat: 5.0, long: 6.7)
//        let place3 = Place(lat: 4.3, long: 6.7)
//        placeArray.append(place1)
//        placeArray.append(place2)
//        placeArray.append(place3)
//        let placesData = try! JSONEncoder().encode(placeArray)
//        UserDefaults.standard.set(placesData, forKey: "favorites")
//    }
//
//    public static func getPlaces() -> [Place]?{
//        let placeData = UserDefaults.standard.data(forKey: "favorites")
//        let placeArray = try! JSONDecoder().decode([Place].self, from: placeData!)
//        return placeArray
//    }
//}
