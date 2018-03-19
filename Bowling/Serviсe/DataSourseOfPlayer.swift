//
//  ServicePlayer.swift
//  Bowling
//
//  Created by Ihar_Karalko on 06.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation

import CoreData

class DataSourseOfPlayer {
    
  private  var context: NSManagedObjectContext
    private var dataSourseOfGame: DataSourseOfGameProtocol!
    
    init(context: NSManagedObjectContext = CoreDataManager.instance.persistentContainer.viewContext){
        self.context = context
        self.dataSourseOfGame = DataSourseOfGame()
     }
}

private extension DataSourseOfPlayer {
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
                guard let id = result.id, let name = result.name else { return players }
                let player = Player(id: id, name: name, scoreGame:  Int(result.scoreGame))
                players.append(player)
            }
        } catch {
            print(error)
        }
        return players
    }
    
    // MARK: - Creates a new [CDPlayer] for CDGame
    func createPlayersOfGame(configurationGame: ConfigurationGame) {
        let cdGameHistory = dataSourseOfGame.saveAndReturnCDGame(configurationGame: configurationGame)
        for index in 0 ... configurationGame.namesOfPlayer.count - 1 {
            let entityDescription = NSEntityDescription.entity(forEntityName: "CDPlayer", in: context)
            let newItem = NSManagedObject(entity: entityDescription!, insertInto: context)
            let player = newItem as? CDPlayer
            guard let cdPlayer = player else { return }
            cdPlayer.id = UUID().uuidString
            cdPlayer.name = configurationGame.namesOfPlayer[index] 
            cdPlayer.scoreGame = 0
            cdPlayer.game = cdGameHistory
            CoreDataManager.instance.saveContext()
        }
    }
    
    // MARK: - Update ScoreGame ForAllPlayer
    func updateScoreGame(idGameSession: String, gamesModels: [GameViewModel]){
         let fetchRequest = NSFetchRequest<CDPlayer>(entityName: "CDPlayer")
        fetchRequest.predicate = NSPredicate(format: "game.id = %@", idGameSession)
        do {
            let results = try context.fetch(fetchRequest)
            for result in results {
                for indexPlayer in 0 ..< gamesModels.count {
                    if result.name == gamesModels[indexPlayer].nameOfPlayerCurrentGame {
                        result.scoreGame = Int16(gamesModels[indexPlayer].currentGame.score)
                    }
                }
            }
        } catch {
            print(error)
        }
        CoreDataManager.instance.saveContext()
    }
}

extension DataSourseOfPlayer: DataSourseOfPlayerProtocol {
    func getPlayersByGameId(currentGameId: String) -> [Player] { return  getPlayersOfGame(currentGameId: currentGameId) }
    func savePlayersOfGame(configurationGame: ConfigurationGame) {
        createPlayersOfGame(configurationGame: configurationGame)
    }
    func updateScoreGamePlayers(idGameSession: String, gamesModels: [GameViewModel]) {
        updateScoreGame(idGameSession: idGameSession, gamesModels: gamesModels)
    }
}
