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
    
    func getPlayersOfGame(currentGame: GameHistory) -> [Player]{
        
        var players = [Player]()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDPlayer")
        fetchRequest.predicate = NSPredicate(format: "game.id = %@", currentGame.id!)
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "scoreGame",
                                                              ascending: false)]
        
        do {
            let results = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequest)
            for result in results as! [CDPlayer] {
                var player = Player()
                player.id =  result.id?.description
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
    func createPlayersOfGame(names: [String], scoreGames: [Int], location: String)  {
        
        let serviceGameHistory  = ServiceGameHistory()
         let cdGameHistory = serviceGameHistory.create(countOfPlayers: names.count, location: location)
        
        for index in 0 ... names.count - 1 {
        // Описание сущности
        let entityDescription = NSEntityDescription.entity(forEntityName: "CDPlayer", in: CoreDataManager.instance.persistentContainer.viewContext)
        
        // Создание нового объекта
        let newItem = NSManagedObject(entity: entityDescription!, insertInto: CoreDataManager.instance.persistentContainer.viewContext)
        
        newItem.setValue(UUID(), forKey: "id")
        newItem.setValue(names[index], forKey: "name")
        newItem.setValue(Int16(scoreGames[index]), forKey: "scoreGame")
        
       // let cdGameHistory = serviceGameHistory.create(countOfPlayers: countOfPlayers, location: location)
        newItem.setValue(cdGameHistory, forKey: "game")
        
        CoreDataManager.instance.saveContext()
        }
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
