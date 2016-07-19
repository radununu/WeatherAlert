//
//  LocationSearchPresenter.swift
//  WeatherAlert
//
//  Created by Radu Nunu on 7/19/16.
//
//

import Foundation

protocol UpdateLocationList: class {
    func updateLocations()
}

class LocationSearchPresenter {
    weak var viewInput: LocationSearchInput?
    var router: AddLocationRouter
    var interactor: LocationSearchInteractor?
    
    init(router: AddLocationRouter) {
        self.router = router
    }
    
    func unpackResponse(response: AnyObject) {
        if let list = response["list"] as? [[String: AnyObject]] {
            let unpackedList = list.map({ (model) -> LocationModel in
                let name: String = (model["name"] as? String) ?? ""
                let country: String = (model["sys"]?["country"] as? String) ?? ""
                return LocationModel(name: name, country: country)
            })
            viewInput?.showLocationList(unpackedList)
        }
    }
}

extension LocationSearchPresenter: LocationSearchOutput {
    func didSelectSearchedLocation(location: LocationModel) {
        
    }
}
