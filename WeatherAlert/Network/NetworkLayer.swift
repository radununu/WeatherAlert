//
//  SearchPlaceNetworkLayer.swift
//  WeatherAlert
//
//  Created by Radu Nunu on 7/19/16.
//
//

import Foundation
import Alamofire

class WeatherNetworkLayer {
    private let baseURL = "http://api.openweathermap.org/data/"
    private let apiVersion = "2.5"
    private let apiKey = "05b11355ff7c4ea7c52120fefff434ac"

    
    func searchForCityName(name: String, completionBlock:((error: NSError?, result: AnyObject?) -> ())) {
        let methodForApiRequest = String(format: "/find?q=%@&type=like&mode=json", name.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.whitespaceCharacterSet())!)
        callApiWith(methodForApiRequest) { (error, result) in
            completionBlock(error: error, result: result)
        }
    }
    
    private func callApiWith(method: String, completionBlock:((error: NSError?, result: AnyObject?) -> ())) {
        let urlString = String(format: "%@%@%@&APPID=%@&lang=en", baseURL, apiVersion, method, apiKey)
        Alamofire.request(.GET, urlString) .responseJSON { response in
            completionBlock(error: response.result.error, result: response.result.value)
        }
    }

}

