 //
 //   ServiceLocation.swift
 //  Bowling
 //
 //  Created by Ihar_Karalko on 06.03.2018.
 //  Copyright © 2018 Ihar_Karalko. All rights reserved.
 //
 
 import Foundation
 import CoreData
 
 class ServiceDataSourseOfLocation  {
    
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext  = CoreDataManager.instance.persistentContainer.viewContext){
        self.context = context
    }
    
    // Creates a new CDLocation
    func create(location: String) -> CDLocation {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDLocation")
        do {
            let results = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequest)
            for result in results as! [CDLocation] {
                if result.location == location {
                    return result
                }
            }
        } catch {
            print(error)
        }
        // Описание сущности
        let entityDescription = NSEntityDescription.entity(forEntityName: "CDLocation", in: CoreDataManager.instance.persistentContainer.viewContext)
        
        // Создание нового объекта
        let newItem = NSManagedObject(entity: entityDescription!, insertInto: CoreDataManager.instance.persistentContainer.viewContext)
        
        
        newItem.setValue(UUID().uuidString, forKey: "id")
        newItem.setValue(location, forKey: "location")
        CoreDataManager.instance.saveContext()
        
        return newItem as! CDLocation
        
    }
    
    
    // get all Location
    func getAll() -> [Location]{
        var locations = [Location]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDLocation")
        do {
            let results = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequest)
            for result in results as! [CDLocation] {
                let location = Location(id: result.id!, location: result.location!)
                locations.append(location)
            }
        } catch {
            print(error)
        }
        return locations
    }
    
    func deleteAll(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDLocation")
        do {
            let results = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequest)
            for result in results as! [CDLocation] {
                CoreDataManager.instance.persistentContainer.viewContext.delete(result)
            }
        } catch {
            print(error)
        }
        CoreDataManager.instance.saveContext()
        
    }
    
    
    
 }

