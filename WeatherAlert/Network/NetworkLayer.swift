//
//  SearchPlaceNetworkLayer.swift
//  WeatherAlert
//
//  Created by Radu Nunu on 7/19/16.
//
//

import Foundation
import Alamofire
import PromiseKit

typealias NetworkResult = Alamofire.Result<[String: AnyObject]>

class WeatherNetworkLayer {
    fileprivate let baseURL = "http://api.openweathermap.org/data/"
    fileprivate let apiVersion = "2.5"
    fileprivate let apiKey = "05b11355ff7c4ea7c52120fefff434ac"

    
    func getListOfCities(by name: String) ->  Promise<Data> {
        let methodForApiRequest = String(format: "/find?q=%@", name.replacingOccurrences(of: " ", with: ""))
        return executeRequest(with: methodForApiRequest)
    }

    fileprivate func executeRequest(with method: String) ->  Promise<Data> {
        let urlString = String(format: "%@%@%@&APPID=%@&lang=en", baseURL, apiVersion, method, apiKey)
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        return firstly {
            Alamofire.request(urlString, method: .get).responseData()
            }.then(execute: { data in
               return Promise(value: data)
            }).always {
              UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
    func searchForCityName(_ name: String, completionBlock:@escaping ((_ error: NSError?, _ result: AnyObject?) -> ())) {
        let methodForApiRequest = String(format: "/find?q=%@", name.replacingOccurrences(of: " ", with: ""))
        callApiWith(methodForApiRequest) { (error, result) in
            completionBlock(error, result)
        }
    }
    
    func getForecastDetailsFor(_ locationName: String, completionBlock:@escaping ((_ error: NSError?, _ result: AnyObject?) -> ())) {
        let methodForApiRequest = String(format: "/forecast?q=%@",locationName.replacingOccurrences(of: " ", with: ""))
        callApiWith(methodForApiRequest) { (error, result) in
            completionBlock(error, result)
        }
    }
    
    fileprivate func callApiWith(_ method: String, completionBlock:@escaping ((_ error: NSError?, _ result: AnyObject?) -> ())) {
        let urlString = String(format: "%@%@%@&APPID=%@&lang=en", baseURL, apiVersion, method, apiKey)
        Alamofire.request(urlString, method: .get).responseJSON { response in
            completionBlock(response.result.error as NSError?, response.result.value as AnyObject?)
        }
    }

}

