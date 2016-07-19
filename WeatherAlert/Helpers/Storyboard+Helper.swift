//
//  Storyboard+Helper.swift
//  WeatherAlert
//
//  Created by Radu Nunu on 7/18/16.
//
//

import UIKit

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(self)
    }
}

extension UIViewController: StoryboardIdentifiable {
    
}

extension UIStoryboard {
    
    enum Storyboard: String {
        case FavouriteLocations
        case AddLocation
        case WindForecastDetailView
    }
    
    convenience init(_ storyboard: Storyboard) {
        self.init(name: storyboard.rawValue, bundle: nil)
    }
    
    func instantiateViewController<T: UIViewController where T: StoryboardIdentifiable>(_: T.Type? = nil) -> T {
        let optionalViewController = self.instantiateViewControllerWithIdentifier(T.storyboardIdentifier)
        
        guard let viewController = optionalViewController as? T  else {
            fatalError("Couldn’t instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }
        
        return viewController
    }
}
