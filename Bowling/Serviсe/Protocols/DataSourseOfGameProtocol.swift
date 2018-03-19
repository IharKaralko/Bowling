//
//  ServiceDataSourseOfGameHistoryProtocol.swift
//  Bowling
//
//  Created by Ihar_Karalko on 17.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation

protocol DataSourseOfGameProtocol {
    func getGamesOfLocation(currentLocationId: String) -> [GameHistory]
    func saveAndReturnCDGame(configurationGame: ConfigurationGame) -> CDGame?
}

