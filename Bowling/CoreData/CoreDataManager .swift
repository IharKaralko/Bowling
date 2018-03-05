//
//  CoreDataManager .swift
//  Bowling
//
//  Created by Ihar_Karalko on 05.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation

import CoreData

class CoreDataManager {
    
    // Singleton
    static let instance = CoreDataManager()
    
    private init() {}
    
    // Entity for Name
    func entityForName(entityName: String) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in:
            self.persistentContainer.viewContext)!
    }
    
    func fetchedResultsController(entityName: String, keyForSort: String) -> NSFetchedResultsController<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let sortDescriptor = NSSortDescriptor(key: keyForSort, ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        //  fetchRequest.predicate = NSPredicate(format: "name = %@", "John")
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
               return fetchedResultsController
    }
//    func fetchOrder(entityName: String)->[Order] {
//        var johnOrders = [Order]()
//
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
//        fetchRequest.predicate = NSPredicate(format: "name = %@", "John")
//        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "name",
//                                                              ascending: true)]
//        do {
//            let results = try
//                CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequest)
//
//            let john: Customer = results.first as! Customer
//
//            // print(john.name)
//            johnOrders = john.orders?.allObjects as! [Order]
//            ////            print(johnOrders.count)
//            // for result in johnOrders {
//
//            //              CoreDataManager.instance.persistentContainer.viewContext.delete(result)
//
//            //  print("order - \(String(result.made))")
//            //\(result.value(forKey: "name")!)")
//            // }
//        } catch {
//            print(error)
//        }
//        return johnOrders
//    }
    
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "IharDemoCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
