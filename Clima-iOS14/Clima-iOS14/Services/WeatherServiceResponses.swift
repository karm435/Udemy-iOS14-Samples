//
//  ServiceResponses.swift
//  Clima-iOS14
//
//  Created by Karmjit Singh on 27/7/20.
//

import Foundation

struct CurrentWeatherResonse : Codable {
    var name: String
    var main: Main
    var weather: [WeatherItem]
}
struct Main : Codable {
    var temp: Double
}
struct WeatherItem : Codable {
    var description: String
    var id: Int
}
