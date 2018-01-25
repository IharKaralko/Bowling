//
//  CountOfPlayerCoordinator.swift
//  Bowling
//
//  Created by Ihar_Karalko on 18.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit

class CountOfPlayerCoordinator {
    private var namesOfPlayersCoordinator: NamesOfPlayersCoordinator?
    var navController: UINavigationController?
    
    init(_ navController: UINavigationController) {
        self.navController = navController
    }
}

extension CountOfPlayerCoordinator {
    func start() {
        let countOfPlayerViewController = CountOfPlayerViewController()
        let viewModel = CountOfPlayerViewModel()
        viewModel.coordinatorDelegate = self
        countOfPlayerViewController.viewModel = viewModel
        navController?.viewControllers = [countOfPlayerViewController]
    }
}

// MARK: - CountOfPlayerViewModelDelegate
extension CountOfPlayerCoordinator: CountOfPlayerViewModelDelegate {
    func countOfPlayerViewModelDidSelect(_ count: Int) {
        namesOfPlayersCoordinator = NamesOfPlayersCoordinator()
        namesOfPlayersCoordinator?.delegate = self
        namesOfPlayersCoordinator?.start(count, navController!)
    }
}

// MARK: - NamesOfPlayersCoordinatorDelegate
extension CountOfPlayerCoordinator: NamesOfPlayersCoordinatorDelegate {
    func namesOfPlayersCoordinatorCancel() {
        if let navController = navController {
            navController.popViewController(animated: true)
        }
        namesOfPlayersCoordinator = nil
    }
}
