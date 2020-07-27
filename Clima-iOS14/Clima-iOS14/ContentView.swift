//
//  ContentView.swift
//  Clima-iOS14
//
//  Created by Karmjit Singh on 17/7/20.
//

import SwiftUI
import os

struct ContentView: View {
    let logger = Logger(subsystem: "com.KarmjitSingh.Clima", category: "main")

    @ObservedObject var weather: WeatherViewModel
    @State var cityName: String = ""
    @State var emptySearchAlert = false
    
    init(weatherViewModel: WeatherViewModel) {
        self.weather = weatherViewModel
    }
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width)
                .edgesIgnoringSafeArea(.all)
            VStack {
                SearchBar(searchTerm: $cityName, action:lookupWeather, locationAction: lookupLocationWeather)
                HStack{
                    Spacer()
                    WeatherIndicator(weatherCondition: self.weather.weatherModel.conditionName)
                        .frame(width: 120, height: 120, alignment: .center)
                }
                HStack(alignment: .top) {
                    Spacer()
                    TempratureView(temprature: self.weather.weatherModel.temprature)
                }
                HStack(alignment: .top) {
                    Spacer()
                    Text(self.weather.weatherModel.cityName)
                        .font(.system(size: 30))
                }
                .padding(.trailing)
                
                Spacer()
            }
        }
        .font(.system(.body, design: .rounded))
        .alert(isPresented: $emptySearchAlert) {
            Alert(title: Text("City"), message: Text("Enter city name"), dismissButton: .cancel())
        }
        .onAppear(){
            weather.getWeatherForCurrentLocation()
        }
    }
    func lookupLocationWeather() {
        weather.getWeatherForCurrentLocation()
    }
    func lookupWeather(){
        guard cityName.count > 0 else {
            emptySearchAlert = true
            return
        }
        
        // Get the weather
        weather.getWeather(for: cityName)
    }
}

struct ContentView_Previews: PreviewProvider {
    static let weatherService = WeatherService()
    static var previews: some View {
        Group {
            ContentView(weatherViewModel: WeatherViewModel(weatherService: weatherService))
            ContentView(weatherViewModel: WeatherViewModel(weatherService: weatherService))     .preferredColorScheme(.dark)
            ContentView(weatherViewModel: WeatherViewModel(weatherService: weatherService))
                .previewDevice("iPad Pro (12.9-inch) (4th generation)")
                .preferredColorScheme(.dark)
        }
    }
}
