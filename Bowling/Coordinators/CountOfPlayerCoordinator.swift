//
//  CountOfPlayerCoordinator.swift
//  Bowling
//
//  Created by Ihar_Karalko on 18.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result
import ReactiveCocoa

protocol CountOfPlayerCoordinatorProtocol {
    func start()
}

class CountOfPlayerCoordinator {
    private weak var navController: UINavigationController?
    
    init(_ navController: UINavigationController) {
        self.navController = navController
    }
}

// MARK: - CountOfPlayerCoordinatorProtocol
extension CountOfPlayerCoordinator: CountOfPlayerCoordinatorProtocol {
    func start(){
        return startCoordinator()
    }
}

private extension CountOfPlayerCoordinator {
    func startCoordinator() {
        guard let navController = navController else { return }
        
        let countOfPlayerViewController = CountOfPlayerViewController()
        let viewModel = CountOfPlayerViewModel()
        countOfPlayerViewController.viewModel = viewModel
        
        bindViewModel(viewModel)
        navController.viewControllers = [countOfPlayerViewController]
    }
    
    func bindViewModel(_ viewModel: CountOfPlayerOutputProtocol) {
        viewModel.output.observeValues { [weak self] value in
            switch value {
            case .inputCountOfPlayers(let count):
                self?.countOfPlayerDidSelect(count)
            }
        }
    }
    
    func countOfPlayerDidSelect(_ count: Int) {
        guard let navController = navController else { return }
        
        var namesOfPlayersCoordinator: Optional<NamesOfPlayersCoordinator> = NamesOfPlayersCoordinator(navController, count)
        let output = namesOfPlayersCoordinator!.start()
        output.observeCompleted {
            namesOfPlayersCoordinator = nil
        }
    }
}

extension CountOfPlayerCoordinator {
    enum Action {
        case inputCountOfPlayers(count: Int)
    }
}
