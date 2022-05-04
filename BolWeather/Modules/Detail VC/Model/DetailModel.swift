//
//  DetailViewModel.swift
//  BolWeather
//
//  Created by Jairo Lopez on 03/05/22.
//

import Foundation
 
class DetailModel: Decodable{
    var consolidated_weather: [Consolidated_weather]
    var parent: ParentLocation
    var sources: [SourcesDetail]
    var time: String
    var sun_rise: String
    var sun_set: String
    var timezone_name: String
    var title: String
    var location_type: String
    var woeid: Int
    var latt_long: String
    var timezone: String
    
    init(){
        consolidated_weather = [Consolidated_weather]()
        parent = ParentLocation()
        sources = [SourcesDetail]()
        time = ""
        sun_rise = ""
        sun_set = ""
        timezone_name = ""
        title = ""
        location_type = ""
        woeid = 0
        latt_long = ""
        timezone = ""
    }
}

class Consolidated_weather: Decodable{
    var id: Int
    var weather_state_name: String
    var weather_state_abbr: String
    var wind_direction_compass: String
    var created: String
    var applicable_date: String
    var min_temp: Double
    var max_temp: Double
    var the_temp: Double
    var wind_speed: Double
    var wind_direction: Double
    var air_pressure: Double
    var humidity: Int
    var visibility: Double
    var predictability: Int
    
    func weatherState()->WeatherStates? {
        return WeatherStates.init(rawValue: self.weather_state_abbr)
    }
}

class ParentLocation: Decodable{
   var title: String
   var location_type: String
   var woeid: Int
   var latt_long: String
    
    init(){
        title = ""
        location_type = ""
        woeid = 0
        latt_long = ""
    }
}

class SourcesDetail: Decodable{
    var title: String
    var slug: String
    var url: String
    var crawl_rate: Int
}

enum WeatherStates: String {
    case sn
    case sl
    case h
    case t
    case hr
    case lr
    case s
    case hc
    case lc
    case c
}
