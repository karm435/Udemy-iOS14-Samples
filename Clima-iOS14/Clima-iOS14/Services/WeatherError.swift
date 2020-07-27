//
//  WeatherError.swift
//  Clima-iOS14
//
//  Created by Karmjit Singh on 27/7/20.
//

import Foundation

enum WeatherError: Error {
    case parsing(description: String)
    case network(description: String)
}
