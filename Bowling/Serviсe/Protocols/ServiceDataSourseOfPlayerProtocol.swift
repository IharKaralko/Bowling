//
//  ServiceDataSourseOfPlayerProtocol.swift
//  Bowling
//
//  Created by Ihar_Karalko on 17.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation

protocol ServiceDataSourseOfPlayerProtocol {
    func getPlayersByCurreentGameId(currentGameId: String) -> [Player]
    func savePlayersOfGameHistory(location: String, idGameSession: String, gamesModel: [GameViewModel])
    func updateScoreGamePlayersOfGameHistory(idGameSession: String, gamesModels: [GameViewModel])
}
