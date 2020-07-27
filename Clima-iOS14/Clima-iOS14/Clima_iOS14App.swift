//
//  Clima_iOS14App.swift
//  Clima-iOS14
//
//  Created by Karmjit Singh on 17/7/20.
//

import SwiftUI

@main
struct Clima_iOS14App: App {
    let weatherService = WeatherService()
    var body: some Scene {
        WindowGroup {
            ContentView(weatherViewModel: WeatherViewModel(weatherService: self.weatherService))
        }
    }
}
