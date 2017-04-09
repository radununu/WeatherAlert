//
//  AddLocationRouter.swift
//  WeatherAlert
//
//  Created by Radu Nunu on 7/18/16.
//
//

import UIKit

class AddLocationRouter {
    var searchController: UISearchController?
    var presentingController: UIViewController?
    
    func presentSearchLocationIn(_ viewController: UIViewController) {
        presentingController = viewController
        let locationController = resultUpdatingController()
        searchController = UISearchController(searchResultsController: locationController)
        searchController?.searchResultsUpdater = locationController
        viewController.present(searchController!, animated: true, completion: nil)
    }
    
    func dissmissAndUpdateLocations() {
        searchController?.dismiss(animated: true, completion: { 
            if let favouriteLocationVC = self.presentingController as? FavouriteLocations {
                favouriteLocationVC.presenter?.didLoadView()
            }
        })
    }
    
    fileprivate func resultUpdatingController() -> AddLocation {
        let updateResult: AddLocation = UIStoryboard(.AddLocation).instantiateViewController()
        let presenter = LocationSearchPresenter(router: self)
        presenter.viewInput = updateResult
        presenter.interactor = LocationSearchInteractor(presenter: presenter)
        updateResult.presenter = presenter
        return updateResult
    }
}
