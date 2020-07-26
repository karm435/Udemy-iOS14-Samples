//
//  WeatherIndicator.swift
//  Clima-iOS14
//
//  Created by Karmjit Singh on 20/7/20.
//

import SwiftUI

struct WeatherIndicator: View {
    var weatherCondition: String
    var body: some View {
        HStack {
            Image(systemName: weatherCondition)
                .resizable()
        }
        .padding()
    }
}

enum WeatherCondition {
    case sunny, raining, cloudy
}

struct WeatherIndicator_Previews: PreviewProvider {
    static var previews: some View {
        WeatherIndicator(weatherCondition: "cloud.rain")
    }
}
