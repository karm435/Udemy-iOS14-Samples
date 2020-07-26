//
//  ContentView.swift
//  Clima-iOS14
//
//  Created by Karmjit Singh on 17/7/20.
//

import SwiftUI
import os

struct ContentView: View {
    @ObservedObject var weather = WeatherViewModel()
    let logger = Logger(subsystem: "com.KarmjitSingh.Clima", category: "main")
    
    @State var cityName: String = ""
    @State var weatherCondition: WeatherCondition = .raining
    @State var temprature: Int = 21
    @State var emptySearchAlert = false
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width)
                .edgesIgnoringSafeArea(.all)
            VStack {
                SearchBar(searchTerm: $cityName, action:lookupWeather)
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
    }
    
    func lookupWeather(){
        guard cityName.count > 0 else {
            emptySearchAlert = true
            return
        }
        
        // Get the weather
        weather.getWeather(for: cityName)
        //cityName = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    @State static var weatherCondition: WeatherCondition = .raining
    @State static var temprature: Int = 21
    @State static var cityName: String = ""
    static var previews: some View {
        Group {
            ContentView(cityName: cityName, weatherCondition: weatherCondition, temprature: temprature)
            ContentView(cityName: cityName, weatherCondition: weatherCondition, temprature: temprature)
                .preferredColorScheme(.dark)
            ContentView(cityName: cityName, weatherCondition: weatherCondition, temprature: temprature)
                .previewDevice("iPad Pro (12.9-inch) (4th generation)")
                .preferredColorScheme(.dark)
        }
    }
}
