//
//  WeatherService.swift
//  Clima-iOS14
//
//  Created by Karmjit Singh on 27/7/20.
//

import Foundation
import Combine
import os

protocol WeatherQuerable {
    func currentWeather(for city: String) -> AnyPublisher<CurrentWeatherResonse, WeatherError>
    func currentWeather(_ latitude: Double, _ longitude: Double) -> AnyPublisher<CurrentWeatherResonse, WeatherError>
}

class WeatherService {
    private let session: URLSession
    let logger = Logger(subsystem: "com.KarmjitSingh.Clima", category: "WeatherViewModel")
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension WeatherService : WeatherQuerable {
    func currentWeather(_ latitude: Double, _ longitude: Double) -> AnyPublisher<CurrentWeatherResonse, WeatherError> {
        getWeather(with: makeComponentsForCurrentDay(latitude: latitude, longitude: longitude))
    }
    
    func currentWeather(for city: String) -> AnyPublisher<CurrentWeatherResonse, WeatherError> {
        getWeather(with: makeComponentsForCurrentDay(withCity: city))
    }
    
    private func getWeather<T>(
        with components: URLComponents)
    -> AnyPublisher<T, WeatherError> where T: Decodable {
        guard let url = components.url else {
            let error = WeatherError.network(description: "Could not create url")
            return Fail(error: error).eraseToAnyPublisher()
        }
        self.logger.debug("url: \(url)")
        return session
            .dataTaskPublisher(for: url)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse) //MARK: how to handle this with catch
                }
                self.logger.debug("data received")
                self.logger.debug("\(element.data)")
                let stringData = String(data: element.data, encoding: .utf8)!
                self.logger.debug("data: \(stringData)")
                return element.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError({(error) -> WeatherError in
                self.logger.debug("decodingerror: \(error.localizedDescription)")
                return WeatherError.parsing(description: error.localizedDescription)
            })
            .eraseToAnyPublisher()
    }
    
}


//MARK: - OpenWeatherMapAPI
private extension WeatherService {
    //https://api.openweathermap.org/data/2.5/weather?appid=5db1c0e42fc691993b9e07594855ad8b&units=metric
    struct OpenWeatherMapAPI {
        static let scheme = "https"
        static let host = "api.openweathermap.org"
        static let path = "/data/2.5"
        static let key = "<Youe key here>" // Check how to secure keys
    }
    
    func makeComponentsForCurrentDay(withCity city: String) -> URLComponents{
            var components = URLComponents()
        components.scheme = OpenWeatherMapAPI.scheme
        components.host = OpenWeatherMapAPI.host
        components.path = OpenWeatherMapAPI.path + "/weather"
        
        components.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "mode", value: "json"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "appid", value: OpenWeatherMapAPI.key)
        ]
        
        return components
    }
    
    func makeComponentsForCurrentDay(latitude: Double, longitude: Double) -> URLComponents{
            var components = URLComponents()
        components.scheme = OpenWeatherMapAPI.scheme
        components.host = OpenWeatherMapAPI.host
        components.path = OpenWeatherMapAPI.path + "/weather"
        
        components.queryItems = [
            URLQueryItem(name: "lat", value: String(latitude)),
            URLQueryItem(name: "lon", value: String(longitude)),
            URLQueryItem(name: "mode", value: "json"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "appid", value: OpenWeatherMapAPI.key)
        ]
        
        return components
    }
}
