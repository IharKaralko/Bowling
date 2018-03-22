//
//  Location .swift
//  Bowling
//
//  Created by Ihar_Karalko on 06.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation
import CoreLocation.CLLocation

struct Location {
    let id: String
    let latitude: String
    let longitude: String
    let adress: String
    var coordinate: CLLocationCoordinate2D? {
        guard let doubleLat = Double(latitude), let doubleLong = Double(longitude) else { return nil }
        return CLLocationCoordinate2D(latitude: doubleLat, longitude: doubleLong)
    }
    
    init(id: String,  latitude: String, longitude: String, adress: String) {
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.adress = adress
    }
 }
