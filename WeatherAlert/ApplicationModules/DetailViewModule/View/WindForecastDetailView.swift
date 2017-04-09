//
//  WindForecastDetailView.swift
//  WeatherAlert
//
//  Created by Radu Nunu on 7/19/16.
//
//

import UIKit

protocol ForecastDetailsViewInput: class {
    func showFetchedForecastDetails(_ forecastDetails: [ForecastWindModel])
}


class WindForecastDetailView: UIViewController {
    @IBOutlet weak var spiner: UIImageView!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var windForecastByDays = [ForecastWindModel]()
    var presenter: DetailViewPresenter?
    fileprivate let reuseIdentifierCell = "WindForecastCellIdentifier"
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        title = presenter?.location.name
        tableView.tableFooterView = UIView()
        presenter?.getDataFromAPI()
    }
    
    func customizeHeaderViewFor(_ model: ForecastWindModel) {
        self.spiner.transform = CGAffineTransform(rotationAngle: CGFloat(DegreesHelper().degreesToRadians(model.degrees)))
        self.windSpeedLabel.text = model.formattedSpeed()
    }
}

extension WindForecastDetailView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return windForecastByDays.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierCell, for: indexPath)
        cell.textLabel?.text = windForecastByDays[indexPath.row].weekDay()
        cell.detailTextLabel?.text = windForecastByDays[indexPath.row].formattedSpeed()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        customizeHeaderViewFor(windForecastByDays[indexPath.row])
    }

}

extension WindForecastDetailView: ForecastDetailsViewInput {
    func showFetchedForecastDetails(_ forecastDetails: [ForecastWindModel]) {
        self.windForecastByDays = forecastDetails
        self.tableView.reloadData()
        if windForecastByDays.count > 0 {
            self.customizeHeaderViewFor(windForecastByDays[0])
        }
    }
}
