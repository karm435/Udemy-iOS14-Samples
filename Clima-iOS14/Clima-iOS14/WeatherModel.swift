//
//  WeatherModel.swift
//  Clima-iOS14
//
//  Created by Karmjit Singh on 22/7/20.
//

import Foundation

class WeatherModel : ObservableObject {
    @Published var conditionId: Int
    @Published var cityName: String
    @Published var temprature: Double
    
    init(id: Int, city: String, temp: Double) {
        conditionId = id;
        cityName = city;
        temprature = temp;
    }
    
    func setCity(to cityName: String){
        self.cityName = cityName
    }
    
    static var defaultWeather: WeatherModel {
        WeatherModel(id: 0, city: "", temp: 0.0)
    }
    
    var conditionName: String  {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "clod.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
}
