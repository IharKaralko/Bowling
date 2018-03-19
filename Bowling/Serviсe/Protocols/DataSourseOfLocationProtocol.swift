//
//  ServiceDataSourseOfLocationProtocol.swift
//  Bowling
//
//  Created by Ihar_Karalko on 16.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation

protocol DataSourseOfLocationProtocol {
    func returnCDLocation(location: String) -> CDLocation?
    func getAllLocations() -> [Location]
    func deleteAllCDLocations()
}
