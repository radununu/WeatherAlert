//
//  FavouriteLocations.swift
//  WeatherAlert
//
//  Created by Radu Nunu on 7/18/16.
//
//

import UIKit

protocol FavouriteInputProtocol: class {
    func loadFavouritesLocations(locations: [FavouriteLocation])
}

protocol FavouriteOutputProtocol: class {
    func didSelectForWindDetailsLocation(location: FavouriteLocation)
    func didSelectAddFavouriteLocation()
}

class FavouriteLocations: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var presenter: FavouriteLocationPresenter?
    private let cellIdentifier = "LocationCellIdentifier"
    private var favouriteLocations = [FavouriteLocation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.didLoadView()
        configureView()
    }

    private func configureView() {
        let addLocationItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addLocationAction))
        navigationItem.rightBarButtonItem = addLocationItem
        title = "Weather Locations"
        self.tableView.tableFooterView = UIView()
    }
    
    func addLocationAction() {
        presenter?.didSelectAddFavouriteLocation()
    }
}

extension FavouriteLocations: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteLocations.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.textLabel?.text = favouriteLocations[indexPath.row].name
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        presenter?.didSelectForWindDetailsLocation(favouriteLocations[indexPath.row])
    }
}

extension FavouriteLocations: FavouriteInputProtocol {
    func loadFavouritesLocations(locations: [FavouriteLocation]) {
        self.favouriteLocations = locations
        self.tableView.reloadData()
    }
}
