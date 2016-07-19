//
//  LocationSearchInteractor.swift
//  WeatherAlert
//
//  Created by Radu Nunu on 7/19/16.
//
//

import Foundation

class LocationSearchInteractor {
    weak var presenter: LocationSearchPresenter?
    let network: WeatherNetworkLayer = WeatherNetworkLayer()
    init(presenter: LocationSearchPresenter) {
        self.presenter = presenter
    }
    
    func searchCityByName(name: String) {
        network.searchForCityName(name) { (error, result) in
            if let unrwappedResponse = result {
                print(result)
                self.presenter?.unpackResponse(unrwappedResponse)
            }
        }
    }
}
