//
//  DetailViewRouter.swift
//  WeatherAlert
//
//  Created by Radu Nunu on 7/19/16.
//
//

import Foundation
import UIKit

class DetailViewRouter {
 
    func pushForecastDetailsOf(_ location: FavouriteLocation, navigation: UINavigationController) {
        let view: WindForecastDetailView = UIStoryboard(.WindForecastDetailView).instantiateViewController()
        let presenter = DetailViewPresenter(router: self, location: location)
        presenter.interactor = DetailViewInteractor(presenter: presenter)
        presenter.viewInput = view
        view.presenter = presenter
        navigation.pushViewController(view, animated: true)
    }
}
