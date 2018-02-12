//
//  ShowListOfNameCoordinator .swift
//  Bowling
//
//  Created by Ihar_Karalko on 18.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit

protocol NamesOfPlayersCoordinatorDelegate: class {
    func namesOfPlayersCoordinatorCancel()
}

class NamesOfPlayersCoordinator {
    
    deinit {
        print("NamesOfPlayersCoordinator deinit")
    }
    weak var delegate: NamesOfPlayersCoordinatorDelegate?
    private weak var navigationController: UINavigationController?
    private var gameSessionCoordinator: GameSessionCoordinator?
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension NamesOfPlayersCoordinator {
    func start(_ count: Int) {
        let namesOfPlayersViewController = NamesOfPlayersViewController()
        let viewModel = NamesOfPlayersViewModel(countOfPlayers: count)
        viewModel.coordinatorDelegate = self
        namesOfPlayersViewController.viewModel = viewModel
        navigationController?.pushViewController(namesOfPlayersViewController, animated: true)
    }
}

// MARK: - NamesOfPlayersViewModelDelegate
extension NamesOfPlayersCoordinator: NamesOfPlayersViewModelDelegate {
    func namesOfPlayersViewModelDidSelect(_ collectionOfNames: [String]) {
        guard let navigationController = navigationController else { return }
        gameSessionCoordinator = GameSessionCoordinator(navigationController)
        gameSessionCoordinator?.start(collectionOfNames)
    }
    
    func namesOfPlayersViewModelDoneBack() {
        delegate?.namesOfPlayersCoordinatorCancel()
    }
}
