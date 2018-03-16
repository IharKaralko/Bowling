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
    
    private var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext  = CoreDataManager.instance.persistentContainer.viewContext){
        self.context = context
    }
    
    // Creates a new CDLocation
    func create(location: String)  {
        
        let fetchRequest = NSFetchRequest<CDLocation>(entityName: "CDLocation")
        do {
            let results = try context.fetch(fetchRequest)
            for result in results  {
                if result.location == location {
                    return //result
                }
            }
        } catch {
            print(error)
        }
       
        let entityDescription = NSEntityDescription.entity(forEntityName: "CDLocation", in: context)
        let newItem = NSManagedObject(entity: entityDescription!, insertInto: context)
        newItem.setValue(UUID().uuidString, forKey: "id")
        newItem.setValue(location, forKey: "location")
       // let ddd:CDLocation = newItem 
        CoreDataManager.instance.saveContext()
        
        //return newItem as! CDLocation
        
    }
    
     func fetchCDLocation(location: String) -> CDLocation {
        
        let fetchRequest = NSFetchRequest<CDLocation>(entityName: "CDLocation")
         fetchRequest.predicate = NSPredicate(format: "location = %@", location)
          var final = CDLocation()
        do {
            let results = try context.fetch(fetchRequest)
            guard let result = results.first else { return final }
            final = result
        } catch {
            print(error)
        }
  
        //    func createOne(location: String) {
//
//        let entityDescription = NSEntityDescription.entity(forEntityName: "CDLocation", in: context)
//        let newItem = NSManagedObject(entity: entityDescription!, insertInto: context)
//        newItem.setValue(UUID().uuidString, forKey: "id")
//        newItem.setValue(location, forKey: "location")
//        CoreDataManager.instance.saveContext()
//
        return final
    }
    
    
    
    
    // get all Location
    func getAll() -> [Location]{
        var locations = [Location]()
        let fetchRequest = NSFetchRequest<CDLocation>(entityName: "CDLocation")
        do {
            let results = try context.fetch(fetchRequest)
            for result in results  {
                let location = Location(id: result.id!, location: result.location!)
                locations.append(location)
            }
        } catch {
            print(error)
        }
        return locations
    }
    
    func deleteAll(){
        let fetchRequest = NSFetchRequest<CDLocation>(entityName: "CDLocation")
        do {
            let results = try context.fetch(fetchRequest)
            for result in results  {
                context.delete(result)
            }
        } catch {
            print(error)
        }
        CoreDataManager.instance.saveContext()
        
    }
    
    
    
 }

