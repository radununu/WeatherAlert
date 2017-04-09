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

class LocationSearchInteractor {
    weak var presenter: LocationSearchPresenter?
    let network: WeatherNetworkLayer = WeatherNetworkLayer()
    let coreDataStack = CoreDataStack.sharedInstance
    init(presenter: LocationSearchPresenter) {
        self.presenter = presenter
    }
    
    func searchCityByName(_ name: String) {
        
        network.getListOfCities(by: name).then { data in
           print("Response______  \(data)")
        }.catch { error in
            print("We have an error ____ \(error)")
        }
        
          print(network.getListOfCities(by: name))
//        network.searchForCityName(name) { (error, result) in
//            if let unrwappedResponse = result {
//                self.presenter?.unpackResponse(unrwappedResponse)
//            }
//        }
    }
    
    func saveSelectedLocation(_ location: LocationModel) {
           if let newEntity =  NSEntityDescription.entity(forEntityName: "FavouriteLocation",
                                                                 in:coreDataStack.managedObjectContext) {
            let locationObject = NSManagedObject(entity: newEntity,
                                           insertInto: coreDataStack.managedObjectContext)
            locationObject.setValue(location.locationName, forKey: "name")
            do {
                try coreDataStack.managedObjectContext.save()
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
        }
        defer {
            presenter?.router.dissmissAndUpdateLocations()
        }
    }
}
