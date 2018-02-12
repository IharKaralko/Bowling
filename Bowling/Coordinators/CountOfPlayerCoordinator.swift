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
    private weak var navController: UINavigationController?
    
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
        guard let navController = navController else { return }
        navController.viewControllers = [countOfPlayerViewController]
    }
}

// MARK: - CountOfPlayerViewModelDelegate
extension CountOfPlayerCoordinator: CountOfPlayerViewModelDelegate {
    func countOfPlayerViewModelDidSelect(_ count: Int) {
        guard let navController = navController else { return }
        namesOfPlayersCoordinator = NamesOfPlayersCoordinator(navController)
        namesOfPlayersCoordinator?.delegate = self
        namesOfPlayersCoordinator?.start(count)
    }
}

// MARK: - NamesOfPlayersCoordinatorDelegate
extension CountOfPlayerCoordinator: NamesOfPlayersCoordinatorDelegate {
    func namesOfPlayersCoordinatorCancel() {
        guard  let navController = navController else { return }
        navController.popViewController(animated: true)
        namesOfPlayersCoordinator = nil
    }
}
