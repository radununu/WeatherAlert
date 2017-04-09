//
//  FavouriteLocations.swift
//  WeatherAlert
//
//  Created by Radu Nunu on 7/18/16.
//
//

import UIKit

protocol FavouriteInputProtocol: class {
    func loadFavouritesLocations(_ locations: [FavouriteLocation])
}

protocol FavouriteOutputProtocol: class {
    func didSelectForWindDetailsLocation(_ location: FavouriteLocation)
    func didSelectAddFavouriteLocation()
}

class FavouriteLocations: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var presenter: FavouriteLocationPresenter?
    fileprivate let cellIdentifier = "LocationCellIdentifier"
    fileprivate var favouriteLocations = [FavouriteLocation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.didLoadView()
        configureView()
    }

    fileprivate func configureView() {
        let addLocationItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addLocationAction))
        navigationItem.rightBarButtonItem = addLocationItem
        title = "Weather Locations"
        self.tableView.tableFooterView = UIView()
    }
    
    func addLocationAction() {
        presenter?.didSelectAddFavouriteLocation()
    }
}

extension FavouriteLocations: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = favouriteLocations[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.didSelectForWindDetailsLocation(favouriteLocations[indexPath.row])
    }
}

extension FavouriteLocations: FavouriteInputProtocol {
    func loadFavouritesLocations(_ locations: [FavouriteLocation]) {
        self.favouriteLocations = locations
        self.tableView.reloadData()
    }
}
