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
}

extension NamesOfPlayersCoordinator {
    func start(_ count: Int, _ nav: UINavigationController) {
        let namesOfPlayersViewController = NamesOfPlayersViewController()
        namesOfPlayersViewController.countPlayers = count
        let viewModel = NamesOfPlayersViewModel()
        viewModel.coordinatorDelegate = self
        namesOfPlayersViewController.viewModel = viewModel
        nav.pushViewController(namesOfPlayersViewController, animated: true)
    }
}

// MARK: - NamesOfPlayersViewModelDelegate
extension NamesOfPlayersCoordinator: NamesOfPlayersViewModelDelegate {
    func namesOfPlayersViewModelDidSelect(_ collectionOfNames: [String]) {
        print("Get")
        print(collectionOfNames)
    }
    
    func namesOfPlayersViewModelDoneBack() {
        delegate?.namesOfPlayersCoordinatorCancel()
    }
}
