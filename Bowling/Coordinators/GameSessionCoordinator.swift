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
    private weak var navigController: UINavigationController?
    init(_ navigController: UINavigationController) {
        self.navigController = navigController
    }
}

extension  GameSessionCoordinator {
    func start(_ collectionOfNames: [String]) {
        let gameSessionViewController = GameSessionViewController()
        let viewModel = GameSessionViewModel(names: collectionOfNames)
       // viewModel.names = collectionOfNames
        viewModel.coordinatorDelegate = self
        gameSessionViewController.viewModel = viewModel
        navigController?.pushViewController(gameSessionViewController, animated: true)
      }
}

// MARK: - NamesOfPlayersViewModelDelegate
extension GameSessionCoordinator:  GameSessionViewModelDelegate {
       
    func gameSessionViewModelDoneBack() {
        guard let navigController = navigController else { return }
        navigController.popViewController(animated: true)
     }
}


