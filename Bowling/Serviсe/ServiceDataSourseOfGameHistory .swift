//
//  ServiceGameHistory .swift
//  Bowling
//
//  Created by Ihar_Karalko on 06.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation
import CoreData

class ServiceDataSourseOfGameHistory {
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = CoreDataManager.instance.persistentContainer.viewContext){
        self.context = context
    }
    
    func getGamesOfLocation(currentLocationId: String) -> [GameHistory]{
        
        var games = [GameHistory]()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDGame")
        fetchRequest.predicate = NSPredicate(format: "location.id = %@", currentLocationId)
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "date",
                                                              ascending: true)]
        
        do {
            let results = try context.fetch(fetchRequest)
            for result in results as! [CDGame] {
                let game = GameHistory(id: result.id!, date: result.date!, countOfPlayers: Int(result.countOfPlayers))
                games.append(game)
            }
        } catch {
            print(error)
        }
        return games
        
    }
    
    // Creates a new CDGame
    func create(countOfPlayers: Int, location: String, idGameSession: String)  -> CDGame {
        let serviceLocation = ServiceDataSourseOfLocation()
        let entityDescription = NSEntityDescription.entity(forEntityName: "CDGame", in: context)
        
        // Создание нового объекта
        let newItem = NSManagedObject(entity: entityDescription!, insertInto: context)
        
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
            let results = try context.fetch(fetchRequest)
            for result in results as! [CDGame] {
                context.delete(result)
            }
        } catch {
            print(error)
        }
        CoreDataManager.instance.saveContext()
        
    }
}
