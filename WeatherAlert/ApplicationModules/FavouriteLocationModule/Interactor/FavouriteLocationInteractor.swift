//
//  FavouriteLocationInteractor.swift
//  WeatherAlert
//
//  Created by Radu Nunu on 7/18/16.
//
//

import Foundation

class FavouriteLocationInteractor {
    weak var presenter: FavouriteLocationPresenter?
    
    init(presenter: FavouriteLocationPresenter) {
        self.presenter = presenter
    }
    
}
