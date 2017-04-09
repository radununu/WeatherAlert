//
//  AddLocation.swift
//  WeatherAlert
//
//  Created by Radu Nunu on 7/19/16.
//
//

import UIKit

protocol LocationSearchInput: class {
    func showLocationList(_ list: [LocationModel])
}

protocol LocationSearchOutput: class {
    func didSelectSearchedLocation(_ location: LocationModel)
}

class AddLocation: UITableViewController {
    fileprivate let reuseIdentifierCell = "reuseIdentifierCell"
    fileprivate var locations = [LocationModel]()
    var presenter: LocationSearchPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension AddLocation {
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierCell, for: indexPath)
        cell.textLabel?.text = locations[indexPath.row].autoCompleteName()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.interactor?.saveSelectedLocation(locations[indexPath.row])
    }
}

extension AddLocation: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchedPlace = searchController.searchBar.text {
          presenter?.interactor?.searchCityByName(searchedPlace)
        }
    }
}

extension AddLocation: LocationSearchInput {
    func showLocationList(_ list: [LocationModel]) {
        self.locations = list
        self.tableView.reloadData()
    }
}
