//
//  InitialPageCoordinator.swift
//  Bowling
//
//  Created by Ihar_Karalko on 07.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result
import ReactiveCocoa

protocol InitialPageCoordinatorProtocol {
    func start()
}

class InitialPageCoordinator {
    private weak var navController: UINavigationController?
    
    init(_ navController: UINavigationController) {
        self.navController = navController
    }
}

// MARK: - InitialPageCoordinatorProtocol
extension InitialPageCoordinator: InitialPageCoordinatorProtocol {
    func start(){
        return startCoordinator()
    }
}

private extension InitialPageCoordinator {
    func startCoordinator() {
        guard let navController = navController else { return }
        let initialPageViewController = InitialPageViewController()
        let viewModel = InitialPageViewModel()
        initialPageViewController.viewModel = viewModel
        bindViewModel(viewModel)
        navController.viewControllers = [initialPageViewController]
    }
    
    func bindViewModel(_ viewModel: InitialPageViewModelOutputProtocol) {
        viewModel.output.observeValues { [weak self] value in
            switch value {
            case .startNewGame:
                self?.startNewGame()
            case .showHistory:
                self?.showHistory()
            }
        }
    }
    func startNewGame() {
        guard let navController = navController else { return }
        var locationGameCoordinator: Optional<LocationGameCoordinator> = LocationGameCoordinator(navController)
        let output = locationGameCoordinator!.start()
                output.observeCompleted {
                    locationGameCoordinator = nil
                }
    }
    
    func showHistory(){
         guard let navController = navController else { return }
        var locationsCoordinator: Optional<LocationsCoordinator> = LocationsCoordinator(navController)
        let output = locationsCoordinator!.start()
        output.observeCompleted {
            locationsCoordinator = nil
        }
    }
}
    

extension InitialPageCoordinator {
    enum Action {
        case startNewGame
        case showHistory
    }
}
