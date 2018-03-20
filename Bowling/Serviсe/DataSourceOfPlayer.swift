//
//  ServicePlayer.swift
//  Bowling
//
//  Created by Ihar_Karalko on 06.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation

import CoreData

class DataSourceOfPlayer {
    
  private  var context: NSManagedObjectContext
    private var dataSourceOfGame: DataSourceOfGameProtocol!
    
    init(context: NSManagedObjectContext = CoreDataManager.instance.persistentContainer.viewContext){
        self.context = context
        self.dataSourceOfGame = DataSourceOfGame()
     }
}

private extension DataSourceOfPlayer {
    // MARK: - Get [Player] by CDGame
    func getPlayersOfGame(currentGameId: String) -> [Player]{
        var players = [Player]()
        let fetchRequest = NSFetchRequest<CDPlayer>(entityName: "CDPlayer")
        fetchRequest.predicate = NSPredicate(format: "game.id = %@", currentGameId)
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "scoreGame",
                                                              ascending: false)]
        do {
            let results = try context.fetch(fetchRequest)
            for result in results {
                guard let id = result.id, let name = result.name else {  continue } 
                let player = Player(id: id, name: name, scoreGame:  Int(result.scoreGame))
                players.append(player)
            }
        } catch {
            print(error)
        }
        return players
    }
    
    func createPlayersOfGame(configurationGame: ConfigurationGame, players: [Player]) {
        let cdGameHistory = dataSourceOfGame.saveAndReturnCDGame(configurationGame: configurationGame)
        for index in 0 ... players.count - 1  {
            let entityDescription = NSEntityDescription.entity(forEntityName: "CDPlayer", in: context)
            let newItem = NSManagedObject(entity: entityDescription!, insertInto: context)
            let player = newItem as? CDPlayer
            guard let cdPlayer = player else { continue }
            cdPlayer.id = players[index].id
            cdPlayer.name = players[index].name
            cdPlayer.scoreGame = Int16(players[index].scoreGame)
            
            cdPlayer.game = cdGameHistory
        }
        CoreDataManager.instance.saveContext()
    }
    
    func updateScoreGame(idGameSession: String, players: [Player]) {
        let fetchRequest = NSFetchRequest<CDPlayer>(entityName: "CDPlayer")
        fetchRequest.predicate = NSPredicate(format: "game.id = %@", idGameSession)
        do {
            let results = try context.fetch(fetchRequest)
            for result in results {
                for indexPlayer in 0 ..< players.count {
                    if result.id == players[indexPlayer].id {
                        result.scoreGame = Int16(players[indexPlayer].scoreGame)
                    }
                }
            }
        } catch {
            print(error)
        }
        CoreDataManager.instance.saveContext()
    }

}

extension DataSourceOfPlayer: DataSourceOfPlayerProtocol {
    func getPlayersByGameId(currentGameId: String) -> [Player] { return  getPlayersOfGame(currentGameId: currentGameId) }
    func savePlayersOfGame(configurationGame: ConfigurationGame, players: [Player]) {
        createPlayersOfGame(configurationGame: configurationGame, players: players)
    }
    func updateScoreGamePlayers(idGameSession: String, players: [Player]) {
        updateScoreGame(idGameSession: idGameSession, players: players)
    }
}
