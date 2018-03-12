//
//  ServicePlayer.swift
//  Bowling
//
//  Created by Ihar_Karalko on 06.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation

import CoreData

class ServicePlayer {
    
    func getPlayersOfGameHistory(currentGameId: String) -> [Player]{
        
        var players = [Player]()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDPlayer")
        fetchRequest.predicate = NSPredicate(format: "game.id = %@", currentGameId)
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "scoreGame",
                                                              ascending: false)]
        
        do {
            let results = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequest)
            for result in results as! [CDPlayer] {
                var player = Player()
                player.id =  result.id
                player.name = result.name
                player.scoreGame = Int(result.scoreGame)
                players.append(player)
            }
        } catch {
            print(error)
        }
        return players
        
    }
    
    // Creates a new [CDPlayer] for CDGame
    func createPlayersOfGameHistory(location: String, idGameSession: String, gamesModel: [GameViewModel])  {
        
        let serviceGameHistory  = ServiceGameHistory()
        let cdGameHistory = serviceGameHistory.create(countOfPlayers: gamesModel.count, location: location, idGameSession: idGameSession)
        
        for index in 0 ... gamesModel.count - 1 {
        // Описание сущности
        let entityDescription = NSEntityDescription.entity(forEntityName: "CDPlayer", in: CoreDataManager.instance.persistentContainer.viewContext)
        
        // Создание нового объекта
        let newItem = NSManagedObject(entity: entityDescription!, insertInto: CoreDataManager.instance.persistentContainer.viewContext)
        
        newItem.setValue(gamesModel[index].idCurrentGame, forKey: "id")
        newItem.setValue(gamesModel[index].nameOfPlayerCurrentGame, forKey: "name")
        newItem.setValue(0, forKey: "scoreGame")
        
       // let cdGameHistory = serviceGameHistory.create(countOfPlayers: countOfPlayers, location: location)
        newItem.setValue(cdGameHistory, forKey: "game")
        
        CoreDataManager.instance.saveContext()
        }
    }
    
    func updateScoreGame(idCurrentGame: String){
        
        
    }
    
    
    func deleteAll(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDPlayer")
        do {
            let results = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequest)
            for result in results as! [CDPlayer] {
                CoreDataManager.instance.persistentContainer.viewContext.delete(result)
            }
        } catch {
            print(error)
        }
        CoreDataManager.instance.saveContext()
        
    }
}
