//
//  WeatherManager.swift
//  Clima-iOS14
//
//  Created by Karmjit Singh on 20/7/20.
//

import Foundation
import Combine
import os
import CoreLocation

class  WeatherViewModel : NSObject, ObservableObject {
    @Published var weatherModel: WeatherModel = WeatherModel.defaultWeather
    
    private let weatherService: WeatherService
    let logger = Logger(subsystem: "com.KarmjitSingh.Clima", category: "WeatherViewModel")
    private var sub = Set<AnyCancellable>()
    
    private let locationManager = CLLocationManager()
    
    init(weatherService: WeatherService) {
        self.weatherService = weatherService
        super.init()
        locationManager.delegate = self
    }
    
    public func canAccessLocation() -> Bool {
        let access = self.locationManager.authorizationStatus()
        return access == .authorizedAlways || access == .authorizedWhenInUse
    }
    
    func requestLocationData() {
        if(self.locationManager.authorizationStatus() == .notDetermined) {
            self.locationManager.requestWhenInUseAuthorization()
        }
        if(canAccessLocation()){
            self.locationManager.requestLocation()
        }
    }
    
    func getWeather(for city: String){
        weatherService.currentWeather(for: city)
            .map { WeatherModel(id:$0.weather[0].id,city: $0.name,temp: $0.main.temp)
            }
            .replaceError(with: WeatherModel(id: 0, city: "", temp: 0.0))
            .receive(on: DispatchQueue.main)
            .assign(to: \.weatherModel, on: self)
            .store(in: &sub)
    }
    
    func getWeatherForCurrentLocation() {
        self.requestLocationData()
    }
    
    private func getWeather(_ latitude: Double, _ longitude: Double) {
        weatherService.currentWeather(latitude, longitude)
            .map { WeatherModel(id:$0.weather[0].id,city: $0.name,temp: $0.main.temp)
            }
            .replaceError(with: WeatherModel(id: 0, city: "", temp: 0.0))
            .receive(on: DispatchQueue.main)
            .assign(to: \.weatherModel, on: self)
            .store(in: &sub)
    }
}

extension WeatherViewModel : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error){
        logger.debug("\(error.localizedDescription)")
        
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            locationManager.stopUpdatingLocation()
            self.getWeather(lastLocation.coordinate.latitude, lastLocation.coordinate.longitude)
        }
    }
}
