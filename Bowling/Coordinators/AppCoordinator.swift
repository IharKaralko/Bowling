//
//  AppCoordinator.swift
//  Bowling
//
//  Created by Ihar_Karalko on 18.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit

class AppCoordinator {
    
    var window: UIWindow
    var countOfPlayerCoordinator: CountOfPlayerCoordinator?
    
    init(window: UIWindow)
    {
        self.window = window
    }
}

// MARK: - Coordinator protocol
extension AppCoordinator: Coordinator {
    
    func start() {
        let navContr = UINavigationController()
        showCountOfPlayers()
        // showNamesOfPlayers()
    }
}
extension AppCoordinator {
 
    func showCountOfPlayers()
    {
         countOfPlayerCoordinator = CountOfPlayerCoordinator(window: window)
        countOfPlayerCoordinator?.delegate = self
        countOfPlayerCoordinator?.start()
    }
}

extension AppCoordinator: CountOfPlayerCoordinatorDelegate {
    func countOfPlayerCoordinatorDidFinish(coordinator: CountOfPlayerCoordinator) {
         print("Ok")
        countOfPlayerCoordinator = nil
        // showNamesOfPlayers()
    }
}

//extension AppCoordinator
//{
//    func showNamesOfPlayers(){
//        let namesOfPlayersCoordinator = NamesOfPlayersCoordinator(window: window)
//        // showListOfNameCoordinator.delegate = self
//        namesOfPlayersCoordinator.start()
//
//    }
//}

