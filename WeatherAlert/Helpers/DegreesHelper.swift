//
//  DegreesHelper.swift
//  WeatherAlert
//
//  Created by Radu Nunu on 7/19/16.
//
//

import Foundation

class DegreesHelper {
    
    func degreesToRadians (value:Double) -> Double {
        return value * M_PI / 180.0
    }
    
    func radiansToDegrees (value:Double) -> Double {
        return value * 180.0 / M_PI
    }
}

extension String {
    func windDirectionFromDegrees(degrees: Double) -> String {
        let directions = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE",
                               "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
        let index = Int((degrees + 11.25) / 22.5)
        return directions[index % 16]
    }
}
