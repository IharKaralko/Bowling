//
//  GameSessionCoordinator.swift
//  Bowling
//
//  Created by Ihar_Karalko on 08.02.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

 import UIKit

class GameSessionCoordinator {
    deinit {
        print("GameSessionCoordinator deinit")
    }
    private var navigController: UINavigationController?
}

extension  GameSessionCoordinator {
    func start(_ collectionOfNames: [String], _ nav: UINavigationController) {
        let gameSessionViewController = GameSessionViewController()
        gameSessionViewController.names = collectionOfNames
        let viewModel = GameSessionViewModel()
        viewModel.coordinatorDelegate = self
        gameSessionViewController.viewModel = viewModel
        nav.pushViewController(gameSessionViewController, animated: true)
        navigController = nav
    }
}

// MARK: - NamesOfPlayersViewModelDelegate
extension GameSessionCoordinator:  GameSessionViewModelDelegate {
    func gameSessionViewModelDoneBack() {
        if let navigController = navigController {
            navigController.popViewController(animated: true)
        }
    }
}


