//
//  test.swift
//  Clima-iOS14
//
//  Created by Karmjit Singh on 20/7/20.
//

import SwiftUI

struct test: View {
    @ObservedObject var weatherViewModel = WeatherViewModel()
    @State var city: String
    var body: some View {
        VStack {
            TextField("CityName", text: $city)
            Text(self.weatherViewModel.weatherModel.cityName)
            Text(self.weatherViewModel.weatherModel.conditionName)
            Button(action: {
                weatherViewModel.getWeather(for: city)
            }, label: {
                Text("Click Me")
            })
        }
    }
}

struct test_Previews: PreviewProvider {
    @State static var city: String = "new"
    static var previews: some View {
        test(city: city)
    }
}
