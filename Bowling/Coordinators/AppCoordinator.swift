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
    init(window: UIWindow)
    {
        self.window = window
    }
    
}
// MARK: - Coordinator protocol
extension AppCoordinator: Coordinator {
    
    func start() {
        //showCountOfPlayers()
        showNamesOfPlayers()
        
    }
}

extension AppCoordinator: CountOfPlayerCoordinatorDelegate {
    func showCountOfPlayers()
    {
        let countOfPlayerCoordinator = CountOfPlayerCoordinator(window: window)
       // countOfPlayerCoordinator.delegate = self
        countOfPlayerCoordinator.start()
    }
    func CountOfPlayerCoordinatorDidFinish(countOfPlayerCoordinator: CountOfPlayerCoordinator){
        // showNamesOfPlayers()
    }
 }
extension AppCoordinator// : CountOfPlayerCoordinatorDelegate
{
    func showNamesOfPlayers(){
        let namesOfPlayersCoordinator = NamesOfPlayersCoordinator(window: window)
        // showListOfNameCoordinator.delegate = self
        namesOfPlayersCoordinator.start()
        
    }
}
