//
//  FavouriteLocationRouter.swift
//  WeatherAlert
//
//  Created by Radu Nunu on 7/18/16.
//
//

import UIKit

class FavouriteLocationRouter {
    
    func getFavouriteLocationsModule() -> UINavigationController {
        let favouriteVC: FavouriteLocations = UIStoryboard(.FavouriteLocations).instantiateViewController()
        let presenter = favouritePresenter()
        presenter.inputView = favouriteVC
        favouriteVC.presenter = presenter
        return UINavigationController(rootViewController: favouriteVC)
    }
    
    private func favouritePresenter() -> FavouriteLocationPresenter {
        let presenter = FavouriteLocationPresenter(router: self)
        presenter.interactor = FavouriteLocationInteractor(presenter: presenter)
        return presenter
    }
    
    func addFavouriteLocationIn(viewInput: UIViewController) {
        AddLocationRouter().presentSearchLocationIn(viewInput)
    }
}
