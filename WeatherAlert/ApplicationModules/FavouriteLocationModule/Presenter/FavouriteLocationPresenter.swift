//
//  FavouriteLocationPresenter.swift
//  WeatherAlert
//
//  Created by Radu Nunu on 7/18/16.
//
//

import UIKit

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
        guard let view = inputView as? UIViewController else { return }
        router.addFavouriteLocationIn(view)
    }
    
    func didSelectForWindDetailsLocation(location: LocationModel) {
        
    }
}
