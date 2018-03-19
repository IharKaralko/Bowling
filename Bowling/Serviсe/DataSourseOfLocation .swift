 //
 //   ServiceLocation.swift
 //  Bowling
 //
 //  Created by Ihar_Karalko on 06.03.2018.
 //  Copyright © 2018 Ihar_Karalko. All rights reserved.
 //
 
 import Foundation
 import CoreData
 
 class DataSourseOfLocation  {
    private var context: NSManagedObjectContext
    init(context: NSManagedObjectContext  = CoreDataManager.instance.persistentContainer.viewContext){
        self.context = context
    }
 }
 
 private extension DataSourseOfLocation {
    // MARK: - Creates a new CDLocation
    func createAndReturnCDLocation(location: String) -> CDLocation? {
        let fetchRequest = NSFetchRequest<CDLocation>(entityName: "CDLocation")
        do {
            let results = try context.fetch(fetchRequest)
            if let fetchedLocation = results.first(where: { $0.location == location }) { return fetchedLocation }
        } catch {
            print(error)
        }
        let entityDescription = NSEntityDescription.entity(forEntityName: "CDLocation", in: context)
        let newItem = NSManagedObject(entity: entityDescription!, insertInto: context)
        
        guard let locationGame = newItem as? CDLocation else { return nil }
        locationGame.id = UUID().uuidString
        locationGame.location = location
        return locationGame
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
 
 extension DataSourseOfLocation: DataSourseOfLocationProtocol {
    func returnCDLocation(location: String) -> CDLocation? {return createAndReturnCDLocation(location: location) }
    func getAllLocations() -> [Location] { return getAll() }
    func deleteAllCDLocations() {  deleteAll() }
 }
 
