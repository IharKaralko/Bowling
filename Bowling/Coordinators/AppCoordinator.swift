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
    var namesOfPlayersCoordinator: NamesOfPlayersCoordinator?
    
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
        countOfPlayerCoordinator = CountOfPlayerCoordinator(window: window)
        countOfPlayerCoordinator?.delegate = self
        countOfPlayerCoordinator?.start()
    }
    
    func showNamesOfPlayers(_ count: Int) {
        namesOfPlayersCoordinator = NamesOfPlayersCoordinator(window: window)
        namesOfPlayersCoordinator?.delegate = self
        print(count)
        namesOfPlayersCoordinator?.start(count)
        
    }
    
}

extension AppCoordinator: CountOfPlayerCoordinatorDelegate {
    func countOfPlayerCoordinatorDidFinish(_ count: Int) {
       //  print("Ok")
        countOfPlayerCoordinator = nil
         showNamesOfPlayers(count)
    }
}

extension AppCoordinator: NamesOfPlayersCoordinatorDelegate {
    func namesOfPlayersCoordinatorDidFinish(collectionOfNames: [String]) {
        print("Get")
        print(collectionOfNames)
        namesOfPlayersCoordinator = nil
    }
}




