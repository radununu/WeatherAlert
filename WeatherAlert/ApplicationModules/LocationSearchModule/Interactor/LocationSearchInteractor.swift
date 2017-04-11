//
//  LocationSearchInteractor.swift
//  WeatherAlert
//
//  Created by Radu Nunu on 7/19/16.
//
//

import Foundation
import CoreData
import PromiseKit
import Alamofire

class LocationSearchInteractor {
    weak var presenter: LocationSearchPresenter?
    let network: WeatherNetworkLayer = WeatherNetworkLayer()
    let coreDataStack = CoreDataStack.sharedInstance
    init(presenter: LocationSearchPresenter) {
        self.presenter = presenter
    }
    
    func searchCityByName(_ name: String) {
        network.getListOfCities(by: name).then { data in
            self.presenter?.unpackResponse(data)
            }.catch { error in
            print(error)
        }
    }
    
    func saveSelectedLocation(_ location: LocationModel) {
        locationManagedObject().then { locationObject in
            locationObject.setValue(location.locationName, forKey: "name")
            }.then { _ in
                try self.coreDataStack.managedObjectContext.save()
            }.always {
                self.presenter?.router.dissmissAndUpdateLocations()
            }.catch { error in
                print(error)
        }
      
    }
    
    fileprivate func locationManagedObject() -> Promise<NSManagedObject> {
        return Promise<NSManagedObject> { fullfiled, reject in
            guard let newEntity =  NSEntityDescription.entity(forEntityName: "FavouriteLocation", in:coreDataStack.managedObjectContext) else  {
                reject(NSError(domain: "Can not get ManagedObject", code: 0, userInfo: ["error": ""]))
                return
            }
            fullfiled(NSManagedObject(entity: newEntity, insertInto: coreDataStack.managedObjectContext))
        }
    }
}
