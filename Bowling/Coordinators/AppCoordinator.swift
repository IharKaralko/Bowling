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
    private var navController: UINavigationController?
    
    init(window: UIWindow)
    {
        self.window = window
    }
}

// MARK: - Methods
extension AppCoordinator {
    func start() {
        navController = UINavigationController()
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        showCountOfPlayers()
    }
    
    func showCountOfPlayers() {
        countOfPlayerCoordinator = CountOfPlayerCoordinator(navController!)
        countOfPlayerCoordinator?.start()
    }
}



