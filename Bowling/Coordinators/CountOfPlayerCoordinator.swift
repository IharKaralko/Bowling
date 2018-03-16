//
//  CountOfPlayerCoordinator.swift
//  Bowling
//
//  Created by Ihar_Karalko on 18.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit
import MapKit
import ReactiveSwift
import Result
import ReactiveCocoa

protocol CountOfPlayerCoordinatorProtocol {
    func start() -> Signal<CountOfPlayerCoordinator.Output, NoError>
}

class CountOfPlayerCoordinator {
    
    private let configurationGame: ConfigurationGame
    private weak var navController: UINavigationController?
    private let _pipe = Signal<CountOfPlayerCoordinator.Output, NoError>.pipe()
    
    init(_ navController: UINavigationController, _ configurationGame: ConfigurationGame) {
        self.navController = navController
        self.configurationGame = configurationGame
    }
}

// MARK: - CountOfPlayerCoordinatorProtocol
extension CountOfPlayerCoordinator: CountOfPlayerCoordinatorProtocol {
    func start() -> Signal<CountOfPlayerCoordinator.Output, NoError> {
        return startCoordinator()
    }
}

private extension CountOfPlayerCoordinator {
    func startCoordinator()-> Signal<CountOfPlayerCoordinator.Output, NoError> {
        guard let navController = navController else { return .empty }
        let countOfPlayerViewController = CountOfPlayerViewController()
        let viewModel = CountOfPlayerViewModel()
        countOfPlayerViewController.viewModel = viewModel
        bindViewModel(viewModel)
        navController.pushViewController(countOfPlayerViewController, animated: true)
        return _pipe.output
    }
    
    func bindViewModel(_ viewModel: CountOfPlayerOutputProtocol) {
        viewModel.output.observeValues { [weak self] value in
            switch value {
            case .inputCountOfPlayers(let count):
                self?.countOfPlayerDidSelect(count)
            }
        }
        
        viewModel.output.observeCompleted { [weak self] in
            self?.navController?.popViewController(animated: true)
            self?._pipe.input.sendCompleted()
        }
    }
    
    func countOfPlayerDidSelect(_ count: Int) {
        guard let navController = navController else { return }
        var namesOfPlayersCoordinator: Optional<NamesOfPlayersCoordinator> = NamesOfPlayersCoordinator(navController, count, configurationGame)
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
    enum Output {
    }
}
