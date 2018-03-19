//
//  ServiceGameHistory .swift
//  Bowling
//
//  Created by Ihar_Karalko on 06.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation
import CoreData

class DataSourseOfGame {
    private var context: NSManagedObjectContext
    private var dataSourseOfLocation: DataSourseOfLocationProtocol!
    
    init(context: NSManagedObjectContext = CoreDataManager.instance.persistentContainer.viewContext) {
        self.context = context
        self.dataSourseOfLocation = DataSourseOfLocation()
    }
}

private extension DataSourseOfGame {
    // MARK: - Get Games Of Location
    func getGames(currentLocationId: String) -> [GameHistory]{
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
      func createCDGame(configurationGame: ConfigurationGame) -> CDGame? {
        let entityDescription = NSEntityDescription.entity(forEntityName: "CDGame", in: context)
        let newItem = NSManagedObject(entity: entityDescription!, insertInto: context)
        let cdLocation = dataSourseOfLocation.returnCDLocation(location: configurationGame.adressLocation)
        guard let cdGame = newItem as? CDGame else { return nil }
        cdGame.id =  configurationGame.idGameSession
        cdGame.date = Date()
        cdGame.countOfPlayers = Int16(configurationGame.namesOfPlayer.count)
        cdGame.location = cdLocation
        CoreDataManager.instance.saveContext()
        return cdGame
    }
}

extension DataSourseOfGame: DataSourseOfGameProtocol {
    func getGamesOfLocation(currentLocationId: String) -> [GameHistory] { return getGames(currentLocationId: currentLocationId) }
    func saveAndReturnCDGame(configurationGame: ConfigurationGame)-> CDGame? {
        return  createCDGame(configurationGame: configurationGame)
    }
}
