//
//   ServiceLocation.swift
//  Bowling
//
//  Created by Ihar_Karalko on 06.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation
import CoreData

class ServiceLocation {
    
//    var context: NSManagedObjectContext
//    
//    init(context: NSManagedObjectContext){
//        self.context = context
//    }
    
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
    
        newItem.setValue(UUID(), forKey: "id")
        newItem.setValue(location, forKey: "location")
        CoreDataManager.instance.saveContext()
        
        return newItem as! CDLocation
        
    }
    
    
    
//    // Gets a person by id
//    func getById(id: NSManagedObjectID) -> Person? {
//        return context.objectWithID(id) as? Person
//    }
//    
//    // Gets all.
//    func getAll() -> [Person]{
//        return get(withPredicate: NSPredicate(value:true))
//    }
//    
//    // Gets all that fulfill the specified predicate.
//    // Predicates examples:
//    // - NSPredicate(format: "name == %@", "Juan Carlos")
//    // - NSPredicate(format: "name contains %@", "Juan")
//
    // get all Location
    func getAll() -> [Location]{
        var locations = [Location]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDLocation")
        do {
            let results = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequest)
            for result in results as! [CDLocation] {
                var location = Location()
                location.id =  result.id?.description
                location.location = result.location
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
    
//    
//    // Updates a person
//    func update(updatedPerson: Person){
//        if let person = getById(updatedPerson.objectID){
//            person.name = updatedPerson.name
//            person.age = updatedPerson.age
//        }
//    }
//    
//    // Deletes a person
//    func delete(id: NSManagedObjectID){
//        if let personToDelete = getById(id){
//            context.deleteObject(personToDelete)
//        }
//    }
//    
//    // Saves all changes
//    func saveChanges(){
//        do{
//            try context.save()
//        } catch let error as NSError {
//            // failure
//            print(error)
//        }
//    }
//}

}
