//
//  WeatherManager.swift
//  Clima-iOS14
//
//  Created by Karmjit Singh on 20/7/20.
//

import Foundation
import Combine
import os


struct WeatherData : Codable {
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

class  WeatherViewModel : ObservableObject {
    @Published var weatherModel: WeatherModel = WeatherModel.defaultWeather
    
    private var sub: AnyCancellable?
    let logger = Logger(subsystem: "com.KarmjitSingh.Clima", category: "WeatherViewModel")
    let baseUrl = "https://api.openweathermap.org/data/2.5/weather?appid=5db1c0e42fc691993b9e07594855ad8b&units=metric"
    let apiKey = "5db1c0e42fc691993b9e07594855ad8b"

    func setCity(to cityName: String){
        self.weatherModel.cityName = cityName;
    }
    
    func getWeather(for city: String){
        let url = "\(baseUrl)&q=\(city)"

        performTask(urlString: url)
    }
    
     func performTask(urlString: String) {
        if let url = URL(string: urlString) {
            
            logger.debug("url: \(url)")
            
            let urlSession = URLSession.shared
            
            self.sub = urlSession
                .dataTaskPublisher(for: url)
                .tryMap() { element -> Data in
                    guard let httpResponse = element.response as? HTTPURLResponse,
                          httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                    self.logger.debug("data received")
                    self.logger.debug("\(element.data)")
                    return element.data
                }
                .decode(type: WeatherData.self, decoder: JSONDecoder())
                .map({ WeatherModel(id:$0.weather[0].id,city: $0.name,temp: $0.main.temp) })
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
}
