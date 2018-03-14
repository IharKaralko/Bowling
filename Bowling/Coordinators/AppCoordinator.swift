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
    private var initialPageCoordinator: InitialPageCoordinatorProtocol!
    private var navController: UINavigationController?
    
    init(window: UIWindow) {
        self.window = window
    }
}

// MARK: - Methods
extension AppCoordinator {
    func start() {
        navController = UINavigationController()
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        showInitialPage()
    }
    
    func showInitialPage() {
        guard let navController = navController else { return }
        initialPageCoordinator = InitialPageCoordinator(navController)
        initialPageCoordinator.start()
    }
}



