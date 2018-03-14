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
    
    func fetchAdressLocation(location: CLLocation, completion: @escaping (AdressLocation) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            var adressLocation = AdressLocation()
            if let error = error {
                print(error)
            } else if let  country = placemarks?.first?.country,
                let city = placemarks?.first?.locality,
                let name = placemarks?.first?.name
            {
                adressLocation.country = country
                adressLocation.city = city
                adressLocation.name = name
                completion(adressLocation)
            }
        }
    }
    
}

struct AdressLocation {
    var country: String!
    var city: String!
    var name: String!
    var adress: String { return country + " " +  city + " " + name }
}
