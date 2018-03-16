//
//  ConfigurationGame.swift
//  Bowling
//
//  Created by Ihar_Karalko on 12.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation
import MapKit

struct  ConfigurationGame {
    
    var idGameSession: String
    var location:  CLLocationCoordinate2D
    var adressLocation: String
    var namesOfPlayer: [String]
    
    init(location:  CLLocationCoordinate2D, adressLocation: String, namesOfPlayer: [String] = []) {
        self.idGameSession = UUID().uuidString
        self.location = location
        self.adressLocation = adressLocation
        self.namesOfPlayer = namesOfPlayer
    }
    
}
