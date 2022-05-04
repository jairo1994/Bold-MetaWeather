//
//  LocationModel.swift
//  BolWeather
//
//  Created by Jairo Lopez on 03/05/22.
//

import Foundation

class LocationModel: Decodable{
    var title: String
    var location_type: String
    var woeid: Int
    var latt_long: String
}
