//
//  PlayersCoordinator .swift
//  Bowling
//
//  Created by Ihar_Karalko on 13.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit
import MapKit
import ReactiveSwift
import Result
import ReactiveCocoa

protocol PlayersCoordinatorProtocol {
    func start() -> Signal<Void, NoError>
}

class PlayersCoordinator {
    deinit {
        print("GameHistoryCoordinator deinit+")
    }
    
    private var currenGame: GameHistory
    private weak var navigController: UINavigationController?
    private let _pipe = Signal<Void, NoError>.pipe()
    
    init(_ navigController: UINavigationController, currentGame: GameHistory) {
        self.navigController = navigController
        self.currenGame = currentGame
    }
}

extension PlayersCoordinator:  PlayersCoordinatorProtocol {
    func start() -> Signal<Void, NoError> { return startCoordinator() }
}

extension  PlayersCoordinator {
    func startCoordinator() -> Signal<Void, NoError> {
        let playersViewController = PlayersViewController()
        let viewModel = PlayersViewModel(currenGame)
        playersViewController.viewModel = viewModel
        bindViewModel(viewModel)
        navigController?.pushViewController(playersViewController, animated: true)
        return _pipe.output
    }
    
    func bindViewModel(_ viewModel: PlayersViewModelOutputProtocol) {
        viewModel.output.observeCompleted { [weak self] in
            self?.navigController?.popViewController(animated: true)
            self?._pipe.input.sendCompleted()
        }
    }
}







