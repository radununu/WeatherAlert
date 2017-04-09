//
//  ApplicationFlow.swift
//  WeatherAlert
//
//  Created by Radu Nunu on 7/18/16.
//
//

import UIKit

class ApplicationFlow: NSObject {
    
    func addApplicationInWindow(_ window: UIWindow) {
        window.rootViewController = FavouriteLocationRouter().getFavouriteLocationsModule()
        window.makeKeyAndVisible()
    }
}
