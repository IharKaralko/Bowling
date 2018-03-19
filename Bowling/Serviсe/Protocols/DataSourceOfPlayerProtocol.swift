//
//  ServiceDataSourseOfPlayerProtocol.swift
//  Bowling
//
//  Created by Ihar_Karalko on 17.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation

protocol DataSourceOfPlayerProtocol {
    func getPlayersByGameId(currentGameId: String) -> [Player]
    func savePlayersOfGame(configurationGame: ConfigurationGame)
    func updateScoreGamePlayers(idGameSession: String, gamesModels: [GameViewModel])
}
