 //
 //   ServiceLocation.swift
 //  Bowling
 //
 //  Created by Ihar_Karalko on 06.03.2018.
 //  Copyright © 2018 Ihar_Karalko. All rights reserved.
 //
 
 import Foundation
 import CoreData
 
 class DataSourceOfLocation  {
    private var context: NSManagedObjectContext
    init(context: NSManagedObjectContext  = CoreDataManager.instance.persistentContainer.viewContext){
        self.context = context
    }
 }
 
 private extension DataSourceOfLocation {
    // MARK: - Creates a new CDLocation
    func createAndReturnCDLocation(latitude: String, longitude: String, adress: String) -> CDLocation? {
        let fetchRequest = NSFetchRequest<CDLocation>(entityName: "CDLocation")        
        fetchRequest.predicate =  NSPredicate(format: "latitude = %@ AND longitude = %@", latitude, longitude)
        do {
            let results = try context.fetch(fetchRequest)
            if let fetchedLocation = results.first { return fetchedLocation }
        } catch {
            print(error)
        }
        let entityDescription = NSEntityDescription.entity(forEntityName: "CDLocation", in: context)
        let newItem = NSManagedObject(entity: entityDescription!, insertInto: context)
        
        guard let locationGame = newItem as? CDLocation else { return nil }
        locationGame.id = UUID().uuidString
        locationGame.latitude = latitude
        locationGame.longitude = longitude
        locationGame.adress = adress
        return locationGame
    }
    
    // MARK: - Get all Location
    func getAll() -> [Location]{
        var locations = [Location]()
        let fetchRequest = NSFetchRequest<CDLocation>(entityName: "CDLocation")
        do {
            let results = try context.fetch(fetchRequest)
            for result in results  {
                guard let id = result.id, let latitude = result.latitude, let longitude = result.longitude, let adress = result.adress
                    else { continue } 
                let locationGame = Location(id: id, latitude: latitude, longitude: longitude, adress: adress)
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
 
 extension DataSourceOfLocation: DataSourceOfLocationProtocol {
    func returnCDLocation(latitude: String, longitude: String, adress: String) -> CDLocation? {return createAndReturnCDLocation(latitude: latitude, longitude: longitude, adress: adress)}
    func getAllLocations() -> [Location] { return getAll() }
    func deleteAllCDLocations() {  deleteAll() }
 }
 
