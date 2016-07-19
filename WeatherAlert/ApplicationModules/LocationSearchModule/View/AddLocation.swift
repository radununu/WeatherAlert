//
//  AddLocation.swift
//  WeatherAlert
//
//  Created by Radu Nunu on 7/19/16.
//
//

import UIKit

protocol LocationSearchInput: class {
    func showLocationList(list: [LocationModel])
}

protocol LocationSearchOutput: class {
    func didSelectSearchedLocation(location: LocationModel)
}

class AddLocation: UITableViewController {
    private let reuseIdentifierCell = "reuseIdentifierCell"
    private var locations = [LocationModel]()
    var presenter: LocationSearchPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension AddLocation {
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifierCell, forIndexPath: indexPath)
        cell.textLabel?.text = locations[indexPath.row].autoCompleteName()
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        presenter?.interactor?.saveSelectedLocation(locations[indexPath.row])
    }
}

extension AddLocation: UISearchResultsUpdating {
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let searchedPlace = searchController.searchBar.text {
          presenter?.interactor?.searchCityByName(searchedPlace)
        }
    }
}

extension AddLocation: LocationSearchInput {
    func showLocationList(list: [LocationModel]) {
        self.locations = list
        self.tableView.reloadData()
    }
}