//
//  ServiceDataSourseOfGameHistoryProtocol.swift
//  Bowling
//
//  Created by Ihar_Karalko on 17.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation

protocol ServiceDataSourseOfGameHistoryProtocol {

     func getGamesOfCurrentLocation(currentLocationId: String) -> [GameHistory]
     func saveNewCDGame(countOfPlayers: Int, location: String, idGameSession: String)
     func fetchCDGameById(idGameSession: String) -> CDGame
}
