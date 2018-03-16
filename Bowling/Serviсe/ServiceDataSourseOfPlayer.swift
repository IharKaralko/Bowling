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
    
    init(context: NSManagedObjectContext = CoreDataManager.instance.persistentContainer.viewContext){
        self.context = context
    }
    
    func getPlayersOfGameHistory(currentGameId: String) -> [Player]{
        
        var players = [Player]()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDPlayer")
        fetchRequest.predicate = NSPredicate(format: "game.id = %@", currentGameId)
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "scoreGame",
                                                              ascending: false)]
        
        do {
            let results = try context.fetch(fetchRequest)
            for result in results as! [CDPlayer] {
                let player = Player(id: result.id!, name: result.name!, scoreGame:  Int(result.scoreGame))
                players.append(player)
            }
        } catch {
            print(error)
        }
        return players
        
    }
    
    // Creates a new [CDPlayer] for CDGame
    func createPlayersOfGameHistory(location: String, idGameSession: String, gamesModel: [GameViewModel])  {
        
        let serviceGameHistory  = ServiceDataSourseOfGameHistory()
        let cdGameHistory = serviceGameHistory.create(countOfPlayers: gamesModel.count, location: location, idGameSession: idGameSession)
        
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
    
    func updateScoreGame(idCurrentGame: String, scoreGame: Int){
        
        let fetchRequest = NSFetchRequest<CDPlayer>(entityName: "CDPlayer")
        
        fetchRequest.predicate = NSPredicate(format: "id = %@", idCurrentGame)
           do {
            let results = try context.fetch(fetchRequest)
            let result = results.first
            result?.scoreGame = Int16(scoreGame)
           
        } catch {
            print(error)
        }
        
         CoreDataManager.instance.saveContext()
        
    }

    func updateScoreGameForAllPlayer(idGameSession: String, gamesModels: [GameViewModel]){
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDPlayer")
        
        fetchRequest.predicate = NSPredicate(format: "game.id = %@", idGameSession)
        do {
            let results = try context.fetch(fetchRequest)
            var i = 0
            for result in results as! [CDPlayer] {
                result.scoreGame = Int16(gamesModels[i].currentGame.score)
                i += 1
            }
        } catch {
            print(error)
        }
        CoreDataManager.instance.saveContext()
    }
    
    func deleteAll(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDPlayer")
        do {
            let results = try context.fetch(fetchRequest)
            for result in results as! [CDPlayer] {
                context.delete(result)
            }
        } catch {
            print(error)
        }
        CoreDataManager.instance.saveContext()
        
    }
}
