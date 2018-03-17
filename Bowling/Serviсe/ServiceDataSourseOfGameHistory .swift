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
    private var context: NSManagedObjectContext
    private var serviceDataSourseOfLocation: ServiceDataSourseOfLocationProtocol!
    
    init(context: NSManagedObjectContext = CoreDataManager.instance.persistentContainer.viewContext) {
        self.context = context
        self.serviceDataSourseOfLocation = ServiceDataSourseOfLocation()
    }
}

private extension ServiceDataSourseOfGameHistory {
    // MARK: - Get Games Of Location
    func getGamesOfLocation(currentLocationId: String) -> [GameHistory]{
        var games = [GameHistory]()
        let fetchRequest = NSFetchRequest<CDGame>(entityName: "CDGame")
        fetchRequest.predicate = NSPredicate(format: "location.id = %@", currentLocationId)
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "date",
                                                              ascending: true)]
        do {
            let results = try context.fetch(fetchRequest)
            for result in results  {
                guard let id = result.id, let dateOfGame = result.date else { return games }
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat =  "EEE, dd MMM yyyy HH:mm"
                let date = dateFormatter.string(from: dateOfGame)
                let game = GameHistory(id: id, date: date, countOfPlayers: Int(result.countOfPlayers))
                games.append(game)
            }
        } catch {
            print(error)
        }
        return games
    }
    
    // MARK: - Creates a new CDGame
    func createCDGame(countOfPlayers: Int, location: String, idGameSession: String)  {
        let entityDescription = NSEntityDescription.entity(forEntityName: "CDGame", in: context)
        serviceDataSourseOfLocation.checkAndSaveCDLocation(location: location)
        let newItem = NSManagedObject(entity: entityDescription!, insertInto: context)
        newItem.setValue(idGameSession, forKey: "id")
        newItem.setValue(Date(), forKey: "date")
        newItem.setValue(Int16(countOfPlayers), forKey: "countOfPlayers")
        let cdLocation = serviceDataSourseOfLocation.getCDLocation(location: location)
        newItem.setValue(cdLocation, forKey: "location")
        CoreDataManager.instance.saveContext()
    }
    
    // MARK: - get CDGame By IdGame
    func fetchCDGame(idGameSession: String) -> CDGame {
        let fetchRequest = NSFetchRequest<CDGame>(entityName: "CDGame")
        fetchRequest.predicate = NSPredicate(format: "id = %@", idGameSession)
        var cdGame = CDGame()
        do {
            let results = try context.fetch(fetchRequest)
            guard let result = results.first else { return cdGame }
            cdGame = result
        } catch {
            print(error)
        }
        return cdGame
    }
}

extension ServiceDataSourseOfGameHistory: ServiceDataSourseOfGameHistoryProtocol {
    func getGamesOfCurrentLocation(currentLocationId: String) -> [GameHistory] { return getGamesOfLocation(currentLocationId: currentLocationId) }
    func saveNewCDGame(countOfPlayers: Int, location: String, idGameSession: String) {
        createCDGame(countOfPlayers: countOfPlayers, location: location, idGameSession: idGameSession)
    }
    func fetchCDGameById(idGameSession: String) -> CDGame { return fetchCDGame(idGameSession: idGameSession) }
}
