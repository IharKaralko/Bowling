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
 }
 
 private extension ServiceDataSourseOfLocation {
  // MARK: - Creates a new CDLocation
    func createCDLocation(location: String)  {
        let fetchRequest = NSFetchRequest<CDLocation>(entityName: "CDLocation")
        do {
            let results = try context.fetch(fetchRequest)
            for result in results  {
                if result.location == location {
                    return
                }
            }
        } catch {
            print(error)
        }
        let entityDescription = NSEntityDescription.entity(forEntityName: "CDLocation", in: context)
        let newItem = NSManagedObject(entity: entityDescription!, insertInto: context)
        newItem.setValue(UUID().uuidString, forKey: "id")
        newItem.setValue(location, forKey: "location")
        CoreDataManager.instance.saveContext()
    }
    
    func fetchCDLocation(location: String) -> CDLocation {
        let fetchRequest = NSFetchRequest<CDLocation>(entityName: "CDLocation")
        fetchRequest.predicate = NSPredicate(format: "location = %@", location)
        var cdLocation = CDLocation()
        do {
            let results = try context.fetch(fetchRequest)
            guard let result = results.first else { return cdLocation }
            cdLocation = result
        } catch {
            print(error)
        }
        return cdLocation
    }

    // MARK: - Get all Location
    func getAll() -> [Location]{
        var locations = [Location]()
        let fetchRequest = NSFetchRequest<CDLocation>(entityName: "CDLocation")
        do {
            let results = try context.fetch(fetchRequest)
            for result in results  {
                guard let id = result.id, let location = result.location else { return locations }
                let locationGame = Location(id: id, location: location)
                locations.append(locationGame)
            }
        } catch {
            print(error)
        }
        return locations
    }
    
    // MARK: - Delete all Location
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
 
 extension ServiceDataSourseOfLocation: ServiceDataSourseOfLocationProtocol {
    func checkAndSaveCDLocation(location: String){ createCDLocation(location: location) }
    func getCDLocation(location: String) -> CDLocation { return fetchCDLocation(location: location)}
    func getAllLocations() -> [Location] { return getAll() }
    func deleteAllCDLocations() {  deleteAll() }
 }
 
