//
//  FavouriteLocations.swift
//  WeatherAlert
//
//  Created by Radu Nunu on 7/18/16.
//
//

import UIKit

protocol FavouriteInputProtocol: class {
    func loadFavouritesLocations(locations: [AnyObject])
}

protocol FavouriteOutputProtocol: class {
    func didSelectForWindDetailsLocation(location: LocationModel)
    func didSelectAddFavouriteLocation()
}

class FavouriteLocations: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var presenter: FavouriteLocationPresenter?
    private let cellIdentifier = "LocationCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    private func configureView() {
        let addLocationItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addLocationAction))
        navigationItem.rightBarButtonItem = addLocationItem
    }
    
    func addLocationAction() {
        presenter?.didSelectAddFavouriteLocation()
    }
}

extension FavouriteLocations: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
}

extension FavouriteLocations: FavouriteInputProtocol {
    func loadFavouritesLocations(locations: [AnyObject]) {
        
    }
}
