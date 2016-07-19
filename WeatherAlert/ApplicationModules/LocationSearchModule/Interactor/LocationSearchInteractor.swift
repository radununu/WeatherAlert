//
//  LocationSearchInteractor.swift
//  WeatherAlert
//
//  Created by Radu Nunu on 7/19/16.
//
//

import Foundation
import CoreData

class LocationSearchInteractor {
    weak var presenter: LocationSearchPresenter?
    let network: WeatherNetworkLayer = WeatherNetworkLayer()
    let coreDataStack = CoreDataStack.sharedInstance
    init(presenter: LocationSearchPresenter) {
        self.presenter = presenter
    }
    
    func searchCityByName(name: String) {
        network.searchForCityName(name) { (error, result) in
            if let unrwappedResponse = result {
                self.presenter?.unpackResponse(unrwappedResponse)
            }
        }
    }
    
    func saveSelectedLocation(location: LocationModel) {
           if let newEntity =  NSEntityDescription.entityForName("FavouriteLocation",
                                                                 inManagedObjectContext:coreDataStack.managedObjectContext) {
            let locationObject = NSManagedObject(entity: newEntity,
                                           insertIntoManagedObjectContext: coreDataStack.managedObjectContext)
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
