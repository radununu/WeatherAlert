//
//  FavouriteLocationRouter.swift
//  WeatherAlert
//
//  Created by Radu Nunu on 7/18/16.
//
//

import UIKit

class FavouriteLocationRouter {
    var rootNavigation: UINavigationController?
    
    func getFavouriteLocationsModule() -> UINavigationController {
        let favouriteVC: FavouriteLocations = UIStoryboard(.FavouriteLocations).instantiateViewController()
        let presenter = favouritePresenter()
        presenter.inputView = favouriteVC
        favouriteVC.presenter = presenter
        rootNavigation = UINavigationController(rootViewController: favouriteVC)
        return rootNavigation ?? UINavigationController ()
    }
    
    fileprivate func favouritePresenter() -> FavouriteLocationPresenter {
        let presenter = FavouriteLocationPresenter(router: self)
        presenter.interactor = FavouriteLocationInteractor(presenter: presenter)
        return presenter
    }
    
    func addFavouriteLocationIn(_ viewInput: UIViewController) {
        AddLocationRouter().presentSearchLocationIn(viewInput)
    }
    
    func showDetailsForecastWindFor(_ location: FavouriteLocation) {
        if let rootNavigation = rootNavigation {
            DetailViewRouter().pushForecastDetailsOf(location, navigation: rootNavigation)
        }
    }
}
