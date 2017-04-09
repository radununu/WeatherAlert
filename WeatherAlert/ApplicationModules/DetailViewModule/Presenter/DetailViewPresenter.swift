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
    
    func unpackResponseFrom(_ forecastList: [[String: AnyObject]]) {
        var unitDay: Int?
        var forecastDataNeeded = [ForecastWindModel]()
        for model in forecastList {
            guard let stringDate = model["dt_txt"] as? String else { continue }
            let dayIndex = dateHelper.dayIndexFromStringDate(stringDate)
            if dayIndex == 0 || dayIndex != unitDay {
                forecastDataNeeded.append(ForecastWindModel(responseObject: model))
                unitDay = dayIndex
            }
        }
        viewInput?.showFetchedForecastDetails(forecastDataNeeded)
    }
}
