//
//  Location.swift
//  WeatherAlert
//
//  Created by Radu Nunu on 7/18/16.
//
//

import Foundation

struct LocationModel {
    let locationName: String
    let country: String
    
    init(name: String, country: String) {
        self.locationName = name
        self.country = country
    }
    
    func autoCompleteName() -> String {
        return self.locationName + ", \(self.country)"
    }
}
