//
//  ShowListOfNameCoordinator .swift
//  Bowling
//
//  Created by Ihar_Karalko on 18.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result
import ReactiveCocoa

protocol NamesOfPlayersCoordinatorProtocol {
    func start() -> Signal<NamesOfPlayersCoordinator.Output, NoError>
}

class NamesOfPlayersCoordinator {
    
    deinit {
        print("NamesOfPlayersCoordinator deinit")
    }
    private weak var navigationController: UINavigationController?
    private let _pipe = Signal<NamesOfPlayersCoordinator.Output, NoError>.pipe()
    private let countOfPlayers: Int
    
    init(_ navigationController: UINavigationController, _ countOfPlayers: Int) {
        self.navigationController = navigationController
        self.countOfPlayers = countOfPlayers
     }
}

extension NamesOfPlayersCoordinator: NamesOfPlayersCoordinatorProtocol {
    func start() -> Signal<NamesOfPlayersCoordinator.Output, NoError> {
        return startCoordinator()
    }
}

private extension NamesOfPlayersCoordinator {
    func startCoordinator() -> Signal<NamesOfPlayersCoordinator.Output, NoError> {
        let namesOfPlayersViewController = NamesOfPlayersViewController()
        let viewModel = NamesOfPlayersViewModel(countOfPlayers: countOfPlayers)
        namesOfPlayersViewController.viewModel = viewModel
        
        viewModel.output.observeValues { [weak self] value in
            switch value {
            case .namesOfPlayersDidSelect(let names):
                self?.namesOfPlayersDidSelect(names)
            }
        }
        viewModel.output.observeCompleted { [weak self] in
            self?.navigationController?.popViewController(animated: true)
            self?._pipe.input.sendCompleted()
        }
        navigationController?.pushViewController(namesOfPlayersViewController, animated: true)
        return _pipe.output
    }
    
    func namesOfPlayersDidSelect(_ collectionOfNames: [String]) {
        guard let navigationController = navigationController else { return }
        
        var gameSessionCoordinator: Optional<GameSessionCoordinator> = GameSessionCoordinator(navigationController, collectionOfNames)
        let output = gameSessionCoordinator!.start()
        output.observeCompleted {
            gameSessionCoordinator = nil
        }
    }
}

extension NamesOfPlayersCoordinator {
    enum Action {
        case namesOfPlayersDidSelect(names: [String])
    }
    enum Output {
    }
}
