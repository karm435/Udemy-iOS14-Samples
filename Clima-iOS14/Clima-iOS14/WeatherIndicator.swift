//
//  WeatherIndicator.swift
//  Clima-iOS14
//
//  Created by Karmjit Singh on 20/7/20.
//

import SwiftUI

struct WeatherIndicator: View {
    @Binding var weatherCondition: WeatherCondition
    var body: some View {
        HStack {
            switch weatherCondition {
            case .raining:
                Image(systemName: "cloud.rain")
                    .resizable()
            case .sunny:
                Image(systemName: "sun.max")
                    .resizable()
            case .cloudy:
                Image(systemName: "cloud.fill")
                    .resizable()
            }
        }
        .padding()
    }
}

enum WeatherCondition {
    case sunny, raining, cloudy
}

struct WeatherIndicator_Previews: PreviewProvider {
    @State static var weatherCondition: WeatherCondition = .raining
    static var previews: some View {
        WeatherIndicator(weatherCondition: $weatherCondition)
    }
}
