//
//  AppCoordinator.swift
//  Bowling
//
//  Created by Ihar_Karalko on 18.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit

class AppCoordinator {
    
    private weak var window: UIWindow?
    private var countOfPlayerCoordinator: CountOfPlayerCoordinator?
    private var namesOfPlayersCoordinator: NamesOfPlayersCoordinator?
    private var navCon: UINavigationController?
    
    init(window: UIWindow)
    {
        self.window = window
    }
    
}

// MARK: - Coordinator protocol
extension AppCoordinator {
    
    func start() {
        showCountOfPlayers()
    }
    
    func showCountOfPlayers() {
        countOfPlayerCoordinator = CountOfPlayerCoordinator(window: window!)
     //   countOfPlayerCoordinator?.delegate = self
        countOfPlayerCoordinator?.start()
        
      //  navCon = countOfPlayerCoordinator?.navController
        
    }
    
//    func showNamesOfPlayers(_ count: Int) {
//        namesOfPlayersCoordinator = NamesOfPlayersCoordinator()
//    //    namesOfPlayersCoordinator?.delegate = self
//        namesOfPlayersCoordinator?.start(count, nav: navCon!)
//    }
}

//extension AppCoordinator: CountOfPlayerCoordinatorDelegate {
//    func countOfPlayerCoordinatorDidFinish(_ count: Int) {
//        showNamesOfPlayers(count)
//    }
//}

//extension AppCoordinator: NamesOfPlayersCoordinatorDelegate {
//    func namesOfPlayersCoordinatorDidFinish(collectionOfNames: [String]) {
//        print("Get")
//        print(collectionOfNames)
//        //  namesOfPlayersCoordinator = nil
//    }
//
//    func namesOfPlayersCoordinatorCancel() {
//        if let navCon = navCon {
//             navCon.popViewController(animated: true)
//        }
//    }
//
//}




