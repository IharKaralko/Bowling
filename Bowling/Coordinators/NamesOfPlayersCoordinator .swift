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
    func start(_ count: Int) -> Signal<NamesOfPlayersCoordinator.Output, NoError>
}

class NamesOfPlayersCoordinator {
    
    deinit {
        print("NamesOfPlayersCoordinator deinit")
    }
    private weak var navigationController: UINavigationController?
    private let _pipe = Signal<NamesOfPlayersCoordinator.Output, NoError>.pipe()
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension NamesOfPlayersCoordinator: NamesOfPlayersCoordinatorProtocol {
    func start(_ count: Int) -> Signal<NamesOfPlayersCoordinator.Output, NoError>{
        return startCoordinator(count)
    }
}

private extension NamesOfPlayersCoordinator {
    func startCoordinator(_ count: Int) -> Signal<NamesOfPlayersCoordinator.Output, NoError> {
        let namesOfPlayersViewController = NamesOfPlayersViewController()
        let viewModel = NamesOfPlayersViewModel(countOfPlayers: count)
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
        var gameSessionCoordinator: Optional<GameSessionCoordinator> = GameSessionCoordinator(navigationController)
        let output = gameSessionCoordinator!.start(collectionOfNames)
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
