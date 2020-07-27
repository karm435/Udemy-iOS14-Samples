//
//  WeatherManager.swift
//  Clima-iOS14
//
//  Created by Karmjit Singh on 20/7/20.
//

import Foundation
import Combine
import os

class  WeatherViewModel : ObservableObject {
    @Published var weatherModel: WeatherModel = WeatherModel.defaultWeather
    
    private let weatherService: WeatherService
    let logger = Logger(subsystem: "com.KarmjitSingh.Clima", category: "WeatherViewModel")
    private var sub: AnyCancellable?

    init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    func getWeather(for city: String){
        performTask(withCity: city)
    }
    
     func performTask(withCity city: String) {
        self.sub = weatherService.currentWeather(for: city)
                .map({
                    self.logger.debug("mapping \($0.name)")
                       return WeatherModel(id:$0.weather[0].id,city: $0.name,temp: $0.main.temp)
                    
                })
                .replaceError(with: WeatherModel(id: 0, city: "", temp: 0.0))
                .receive(on: DispatchQueue.main)
                //.assign(to: \.weatherModel, on: self)
                .sink( receiveCompletion: {
                   print("Received completion : \($0)")
                }, receiveValue: { value in
                    self.logger.debug("value: \(value.cityName)")
                    self.weatherModel = value
                })
    }
}
