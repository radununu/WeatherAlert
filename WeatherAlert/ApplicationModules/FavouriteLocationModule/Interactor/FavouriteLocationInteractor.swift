//
//  FavouriteLocationInteractor.swift
//  WeatherAlert
//
//  Created by Radu Nunu on 7/18/16.
//
//

import Foundation
import CoreData

class FavouriteLocationInteractor {
    weak var presenter: FavouriteLocationPresenter?
    private let locationEnetityName = "FavouriteLocation"
    let coreDataStack = CoreDataStack.sharedInstance
    
    init(presenter: FavouriteLocationPresenter) {
        self.presenter = presenter
    }
    
    func fetchFavouritesLocations() {
        let fetchRequest = NSFetchRequest(entityName: locationEnetityName)
        do {
            if let locations = try coreDataStack.managedObjectContext.executeFetchRequest(fetchRequest) as? [FavouriteLocation] {
                presenter?.inputView?.loadFavouritesLocations(locations)
            }
        } catch {}
    }
}
