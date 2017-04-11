//
//  DetailViewInteractor.swift
//  WeatherAlert
//
//  Created by Radu Nunu on 7/19/16.
//
//

import Foundation
import PromiseKit

class DetailViewInteractor {
    weak var presenter: DetailViewPresenter?
    let network = WeatherNetworkLayer()
    
    init(presenter: DetailViewPresenter) {
        self.presenter = presenter
    }
    
    func fetchForecastDataFor(_ location: FavouriteLocation) {
        network.getForecastDetailsFor(location.name).then { dataObject in
            return Promise( value: try JSONSerialization.jsonObject(with: dataObject, options: .mutableContainers) as AnyObject)
            }.then { deserialized in
                return Promise(value: deserialized as? [String: AnyObject])
            }.then { response in
                return Promise(value: response?["list"] as! [[String: AnyObject]])
            }.then { list in
              self.presenter?.unpackResponseFrom(list)
            }.catch { error in
                print(error)
        }
    }
   
}
