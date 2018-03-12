//
//  ServiceGameHistory .swift
//  Bowling
//
//  Created by Ihar_Karalko on 06.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation
import CoreData

class ServiceGameHistory{
    
    //var serviceLocation: ServiceLocation!
    
    
    func getGamesOfLocation(currentLocationId: String) -> [GameHistory]{
        
        var games = [GameHistory]()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDGame")
        fetchRequest.predicate = NSPredicate(format: "location.id = %@", currentLocationId)
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "date",
                                                              ascending: true)]
        
        do {
            let results = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequest)
            for result in results as! [CDGame] {
                var game = GameHistory()
                game.id =  result.id
                game.date = result.date
                game.countOfPlayers = Int(result.countOfPlayers)
                games.append(game)
            }
        } catch {
            print(error)
        }
        return games
        
    }
    
    // Creates a new CDGame
    func create(countOfPlayers: Int, location: String, idGameSession: String)  -> CDGame {
        let serviceLocation = ServiceLocation()
      
        // Описание сущности
        let entityDescription = NSEntityDescription.entity(forEntityName: "CDGame", in: CoreDataManager.instance.persistentContainer.viewContext)
        
        // Создание нового объекта
        let newItem = NSManagedObject(entity: entityDescription!, insertInto: CoreDataManager.instance.persistentContainer.viewContext)
        
        newItem.setValue(idGameSession, forKey: "id")
        newItem.setValue(Date(), forKey: "date")
        newItem.setValue(Int16(countOfPlayers), forKey: "countOfPlayers")
        
       let cdLocation = serviceLocation.create(location: location)
       
        newItem.setValue(cdLocation, forKey: "location")
        
        CoreDataManager.instance.saveContext()
        return newItem as! CDGame 
        
    }
    func deleteAll(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDGame")
        do {
            let results = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequest)
            for result in results as! [CDGame] {
                CoreDataManager.instance.persistentContainer.viewContext.delete(result)
            }
        } catch {
            print(error)
        }
          CoreDataManager.instance.saveContext()
        
    }
}
