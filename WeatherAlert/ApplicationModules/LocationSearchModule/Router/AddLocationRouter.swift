//
//  AddLocationRouter.swift
//  WeatherAlert
//
//  Created by Radu Nunu on 7/18/16.
//
//

import UIKit

class AddLocationRouter {
    
    func presentSearchLocationIn(viewController: UIViewController) {
        let resultUpdatingContrller = resultUpdatingController()
        let searchContoller = UISearchController(searchResultsController: resultUpdatingContrller)
        searchContoller.searchBar.delegate = resultUpdatingContrller
        searchContoller.searchResultsUpdater = resultUpdatingContrllers
        viewController.presentViewController(searchContoller, animated: true, completion: nil)
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
