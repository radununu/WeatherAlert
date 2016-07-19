//
//  WindForecastDetailView.swift
//  WeatherAlert
//
//  Created by Radu Nunu on 7/19/16.
//
//

import UIKit

protocol ForecastDetailsViewInput: class {
    func showFetchedForecastDetails(forecastDetails: [ForecastWindModel])
}


class WindForecastDetailView: UIViewController {
    @IBOutlet weak var spiner: UIImageView!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var windForecastByDays = [ForecastWindModel]()
    var presenter: DetailViewPresenter?
    private let reuseIdentifierCell = "WindForecastCellIdentifier"
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        title = presenter?.location.name
        tableView.tableFooterView = UIView()
        presenter?.getDataFromAPI()
    }
    
    func customizeHeaderViewFor(model: ForecastWindModel) {
        self.spiner.transform = CGAffineTransformMakeRotation(CGFloat(DegreesHelper().degreesToRadians(model.degrees)))
        self.windSpeedLabel.text = model.formattedSpeed()
    }
}

extension WindForecastDetailView: UITableViewDelegate, UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return windForecastByDays.count - 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifierCell, forIndexPath: indexPath)
        cell.textLabel?.text = windForecastByDays[indexPath.row].weekDay()
        cell.detailTextLabel?.text = windForecastByDays[indexPath.row].formattedSpeed()
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        customizeHeaderViewFor(windForecastByDays[indexPath.row])
    }

}

extension WindForecastDetailView: ForecastDetailsViewInput {
    func showFetchedForecastDetails(forecastDetails: [ForecastWindModel]) {
        self.windForecastByDays = forecastDetails
        self.tableView.reloadData()
        if windForecastByDays.count > 0 {
            self.customizeHeaderViewFor(windForecastByDays[0])
        }
    }
}
