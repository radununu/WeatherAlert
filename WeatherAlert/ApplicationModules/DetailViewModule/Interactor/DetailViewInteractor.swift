//
//  DetailViewInteractor.swift
//  WeatherAlert
//
//  Created by Radu Nunu on 7/19/16.
//
//

import Foundation

class DetailViewInteractor {
    weak var presenter: DetailViewPresenter?
    let network = WeatherNetworkLayer()
    
    init(presenter: DetailViewPresenter) {
        self.presenter = presenter
    }
    
    func fetchForecastDataFor(_ location: FavouriteLocation) {
        network.getForecastDetailsFor(location.name) { (error, result) in
            guard let response = result as? [String: AnyObject] else { return }
            if let list = response["list"] as? [[String: AnyObject]] {
                self.presenter?.unpackResponseFrom(list)
            }
        }
    }
    
}
