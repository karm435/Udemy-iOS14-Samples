//
//  ContentView.swift
//  Clima-iOS14
//
//  Created by Karmjit Singh on 17/7/20.
//

import SwiftUI

struct ContentView: View {
    @State var weatherCondition: WeatherCondition = .raining
    @State var temprature: Int = 21
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width)
                .edgesIgnoringSafeArea(.all)
            VStack {
                SearchBar()
                HStack{
                    Spacer()
                    WeatherIndicator(weatherCondition: $weatherCondition)
                        .frame(width: 120, height: 120, alignment: .center)
                }
                HStack(alignment: .top) {
                    Spacer()
                    TempratureView(temprature: $temprature)
                }
                HStack(alignment: .top) {
                    Spacer()
                    Text("London")
                        .font(.system(size: 30))
                }
                .padding(.trailing)
                
                Spacer()
            }
        }
        .font(.system(.body, design: .rounded))
    }
}

struct ContentView_Previews: PreviewProvider {
    @State static var weatherCondition: WeatherCondition = .raining
    @State static var temprature: Int = 21
    static var previews: some View {
        Group {
            ContentView(weatherCondition: weatherCondition, temprature: temprature)
            ContentView(weatherCondition: weatherCondition, temprature: temprature)
                .preferredColorScheme(.dark)
        }
    }
}
