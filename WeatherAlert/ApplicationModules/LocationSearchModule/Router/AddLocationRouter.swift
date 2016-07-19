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
    
    func presentSearchLocationIn(viewController: UIViewController) {
        presentingController = viewController
        let locationController = resultUpdatingController()
        searchController = UISearchController(searchResultsController: locationController)
        searchController?.searchResultsUpdater = locationController
        viewController.presentViewController(searchController!, animated: true, completion: nil)
    }
    
    func dissmissAndUpdateLocations() {
        searchController?.dismissViewControllerAnimated(true, completion: { 
            if let favouriteLocationVC = self.presentingController as? FavouriteLocations {
                favouriteLocationVC.presenter?.didLoadView()
            }
        })
    }
    
    private func resultUpdatingController() -> AddLocation {
        let updateResult: AddLocation = UIStoryboard(.AddLocation).instantiateViewController()
        let presenter = LocationSearchPresenter(router: self)
        presenter.viewInput = updateResult
        presenter.interactor = LocationSearchInteractor(presenter: presenter)
        updateResult.presenter = presenter
        return updateResult
    }
}
