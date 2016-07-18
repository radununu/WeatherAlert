//
//  FavouriteLocationPresenter.swift
//  WeatherAlert
//
//  Created by Radu Nunu on 7/18/16.
//
//

import Foundation

class FavouriteLocationPresenter {
    let router: FavouriteLocationRouter
    var interactor: FavouriteLocationInteractor?
    weak var inputView: FavouriteInputProtocol?
    
    init(router: FavouriteLocationRouter) {
        self.router = router
    }
}

extension FavouriteLocationPresenter: FavouriteOutputProtocol {
    func didSelectAddFavouriteLocation() {
        
    }
    
    func didSelectForWindDetailsLocation(location: LocationModel) {
        
    }
}
