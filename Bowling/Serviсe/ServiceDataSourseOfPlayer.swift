//
//  ServicePlayer.swift
//  Bowling
//
//  Created by Ihar_Karalko on 06.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation

import CoreData

class ServiceDataSourseOfPlayer {
    
  private  var context: NSManagedObjectContext
    private var serviceDataSourseOfGameHistory: ServiceDataSourseOfGameHistoryProtocol!
    
    init(context: NSManagedObjectContext = CoreDataManager.instance.persistentContainer.viewContext){
        self.context = context
        self.serviceDataSourseOfGameHistory = ServiceDataSourseOfGameHistory()
     }
}

private extension ServiceDataSourseOfPlayer {
    // MARK: - Get [Player] by CDGame
    func getPlayersOfGameHistory(currentGameId: String) -> [Player]{
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
    func createPlayersOfGameHistory(location: String, idGameSession: String, gamesModel: [GameViewModel])  {
        
        serviceDataSourseOfGameHistory.saveNewCDGame(countOfPlayers: gamesModel.count, location: location, idGameSession: idGameSession)
        let cdGameHistory = serviceDataSourseOfGameHistory.fetchCDGameById(idGameSession: idGameSession)
              
        for index in 0 ... gamesModel.count - 1 {
            let entityDescription = NSEntityDescription.entity(forEntityName: "CDPlayer", in: context)
            let newItem = NSManagedObject(entity: entityDescription!, insertInto: context)
            newItem.setValue(gamesModel[index].idCurrentGame, forKey: "id")
            newItem.setValue(gamesModel[index].nameOfPlayerCurrentGame, forKey: "name")
            newItem.setValue(0, forKey: "scoreGame")
            newItem.setValue(cdGameHistory, forKey: "game")
            CoreDataManager.instance.saveContext()
        }
    }
    
    // MARK: - Update ScoreGame ForAllPlayer
    func updateScoreGameForAllPlayer(idGameSession: String, gamesModels: [GameViewModel]){
        let fetchRequest = NSFetchRequest<CDPlayer>(entityName: "CDPlayer")
        fetchRequest.predicate = NSPredicate(format: "game.id = %@", idGameSession)
        do {
            let results = try context.fetch(fetchRequest)
            var i = 0
            for result in results {
                result.scoreGame = Int16(gamesModels[i].currentGame.score)
                i += 1
            }
        } catch {
            print(error)
        }
        CoreDataManager.instance.saveContext()
    }
}

extension ServiceDataSourseOfPlayer: ServiceDataSourseOfPlayerProtocol {
    func getPlayersByCurreentGameId(currentGameId: String) -> [Player] { return  getPlayersOfGameHistory(currentGameId: currentGameId) }
    func savePlayersOfGameHistory(location: String, idGameSession: String, gamesModel: [GameViewModel]) {
        createPlayersOfGameHistory(location: location, idGameSession: idGameSession, gamesModel: gamesModel)
    }
    func updateScoreGamePlayersOfGameHistory(idGameSession: String, gamesModels: [GameViewModel]) {
        updateScoreGameForAllPlayer(idGameSession: idGameSession, gamesModels: gamesModels)
    }
}
