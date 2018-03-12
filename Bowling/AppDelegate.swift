//
//  AppDelegate.swift
//  Bowling
//
//  Created by Ihar_Karalko on 16.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
      
//       let serviceLocation = ServiceLocation()
//       let serviceGameHistory = ServiceGameHistory()
//        let uuid = UUID()
//        let bbb = serviceLocation.create(location: "Петя")
//        let uu  = UUID()
//      let gameOne =  serviceGameHistory.create(countOfPlayers: 10, location: "Петя")
//        let gameSecond = serviceGameHistory.create(countOfPlayers: 4, location: "Вася")
        
//      let servicePlayer = ServicePlayer()
//         let names = ["Kotic", "Motic", "Rotic", "Sotic"]
//        let scoreGames = [5, 67, 88, 123]
//        let namesOne =  ["K", "M", "R", "S"]
//        let scoreGamesOne = [1,2,3,4]
//               servicePlayer.createPlayersOfGame(names: names, scoreGames: scoreGames, location: "Петя")
//
//                //.create(name: "Kotic", scoreGame: 88, countOfPlayers: 10, location: "Петя")
//        servicePlayer.createPlayersOfGame(names: namesOne, scoreGames: scoreGamesOne, location: "Вася")
          //        servicePlayer.create(name: "Rotic", scoreGame: 181, countOfPlayers: 10, location: "Петя")
//        servicePlayer.create(name: "Sotic", scoreGame: 95, countOfPlayers: 10, location: "Петя")
//
//
//
//        servicePlayer.create(name: "K", scoreGame: 1, countOfPlayers: 4, location: "Вася")
//        servicePlayer.create(name: "M", scoreGame: 2,  countOfPlayers: 4, location: "Вася")
//        servicePlayer.create(name: "R", scoreGame: 3,  countOfPlayers: 4, location: "Вася")
//        servicePlayer.create(name: "N", scoreGame: 4,  countOfPlayers: 4, location: "Вася")
//        servicePlayer.create(name: "S", scoreGame: 5,  countOfPlayers: 4, location: "Вася")
//
   //     var currentGame = GameHistory()
//        var currentGameOne = GameHistory()
        
  //    currentGame.id = "DEECB3FF-A21F-49CA-AFE8-9C7B4C232927"
//         currentGameOne.id =  gameSecond.id?.description
        
 //       let loc = servicePlayer.getPlayersOfGame(currentGame: currentGame)
        //   let aa =  serviceLocation.create(location: "Вася")
//
   //   let loc = serviceLocation.getAll()
     //  serviceLocation.deleteAll()
//        var qqq = Location()
//        qqq.location = "Петя"
//   var lob = Location()
//        lob.location = "Петя"
//      let loc = serviceGameHistory.getGamesOfLocation(currentLocation: lob)
        // serviceGameHistory.deleteAll()
   //     var loc = serviceGameHistory.getGamesOfLocation(currentLocation: qqq)
//       serviceLocation.deleteAll()
       
        
        
       // let loc =  serviceLocation.getAll()
//        for s in loc{
//            print(s.name)
//          print(s.scoreGame)
//        }
        
        
        //        // Описание сущности
//        let entityDescription = NSEntityDescription.entity(forEntityName: "CDLocation", in: CoreDataManager.instance.persistentContainer.viewContext)
//
//        // Создание нового объекта
//        let managedObject = NSManagedObject(entity: entityDescription!, insertInto: CoreDataManager.instance.persistentContainer.viewContext)

        // Установка значения атрибута
//        let uuid = UUID()
//        managedObject.setValue("ООО «Ромашка»", forKey: "location")
//         managedObject.setValue(uuid, forKey: "id")
       
        // Извлечение значения атрибута
//        let name = managedObject.value(forKey: "location")
//        let id = managedObject.value(forKey: "id")
//        print("name = \(name)")
//        print(id)
//
//        // Запись объекта
     //  CoreDataManager.instance.saveContext()
       
//        serviceLocation.deleteAll()
//        let results = serviceLocation.getAll()
//        for result in results {
//            print(result.id ?? "Саша")
//            print(result.location ?? "САша")
       // }
        // Извление записей
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDLocation")
//        do {
//            let results = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequest)
//            for result in results as! [CDLocation] {
//                print("name - \(result.value(forKey: "location")!)")
//               print("id- \(result.value(forKey: "id")!)")
//            }
//        } catch {
//            print(error)
//        }

        
        
              window = UIWindow(frame:UIScreen.main.bounds)
//        appCoordinator = AppCoordinator(window: window!)
//        appCoordinator.start()
        let locationGameViewController = LocationGameViewController()
        let navController = UINavigationController(rootViewController: locationGameViewController)
//        let demoViewController = DemoViewController()
//        let navController = UINavigationController(rootViewController: demoViewController)
//          let initialPageViewController = InitialPageViewController()
      //    let navController = UINavigationController(rootViewController: initialPageViewController)
         window?.rootViewController = navController
         window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

