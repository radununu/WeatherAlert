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
        guard let result = try? coreDataStack.managedObjectContext.executeFetchRequest(fetchRequest),
            let locations = result as? [FavouriteLocation] else { return }
        presenter?.inputView?.loadFavouritesLocations(locations)
    }
}
