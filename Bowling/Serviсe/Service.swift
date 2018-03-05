//
//  Service.swift
//  Bowling
//
//  Created by Ihar_Karalko on 03.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation
import MapKit

class Service {
    
    // TODO: need to refactor
    func fetchCountryAndCity(location: CLLocation, completion: @escaping (String, String, String) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print(error)
            } else if let country = placemarks?.first?.country,
                let city = placemarks?.first?.locality,
                let name = placemarks?.first?.name
               
            {
                
                completion(country, city, name)
            }
        }
    }
    
}
