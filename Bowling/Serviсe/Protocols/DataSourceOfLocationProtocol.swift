//
//  ServiceDataSourseOfLocationProtocol.swift
//  Bowling
//
//  Created by Ihar_Karalko on 16.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation

protocol DataSourceOfLocationProtocol {
    func returnCDLocation(latitude: String, longitude: String, adress: String) -> CDLocation?
    func getAllLocations() -> [Location]
    func deleteAllCDLocations()
}
