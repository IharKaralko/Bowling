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
    var namesOfPlayer: [String]
    
    init(idGameSession: String, location:  CLLocationCoordinate2D, namesOfPlayer: [String]) {
        self.idGameSession = idGameSession
        self.location = location
        self.namesOfPlayer = namesOfPlayer
    }
    
}
