//
//  DetailViewPresenter.swift
//  WeatherAlert
//
//  Created by Radu Nunu on 7/19/16.
//
//

import Foundation

class DetailViewPresenter {
    let router: DetailViewRouter
    let location: FavouriteLocation
    var interactor: DetailViewInteractor?
    weak var viewInput: ForecastDetailsViewInput?
    let dateHelper = DateHelper()
    
    init(router: DetailViewRouter, location: FavouriteLocation) {
        self.router = router
        self.location = location
    }
    
    func getDataFromAPI() {
        interactor?.fetchForecastDataFor(location)
    }
    
    func unpackResponseFrom(forecastList: [[String: AnyObject]]) {
        var unitDay: Int?
        var forecastDataNeeded = [ForecastWindModel]()
        for model in forecastList {
            let day: Int = dateHelper.dateComponents(dateHelper.dateValueFromString((model["dt_txt"] as! String))).weekday
            if day == 0 || day != unitDay {
                forecastDataNeeded.append(ForecastWindModel(responseObject: model))
                unitDay = day
            }
        }
        viewInput?.showFetchedForecastDetails(forecastDataNeeded)
    }
}
