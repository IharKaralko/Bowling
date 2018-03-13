//
//  GameHistoryCoordinator.swift
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

protocol GameHistoryCoordinatorProtocol {
    func start() -> Signal<Void, NoError>
}

class GameHistoryCoordinator {
    deinit {
        print("GameHistoryCoordinator deinit+")
    }
    
    private var currenLocation: Location
    private weak var navigController: UINavigationController?
    private let _pipe = Signal<Void, NoError>.pipe()
    // private let collectionOfNames: [String]
    
    init(_ navigController: UINavigationController, _ currentLocation: Location) {
        self.navigController = navigController
        //  self.collectionOfNames = collectionOfNames
        self.currenLocation = currentLocation
    }
}

extension GameHistoryCoordinator:  GameHistoryCoordinatorProtocol {
    func start() -> Signal<Void, NoError> {
        return startCoordinator()
    }
}


extension  GameHistoryCoordinator {
    func startCoordinator() -> Signal<Void, NoError> {
        let gameHistoryViewController = GameHistoryViewController()
        
        
        let viewModel = GameHistoryViewModel(currenLocation)
        gameHistoryViewController.viewModel = viewModel
        
        bindViewModel(viewModel)
        //        navController.pushViewController(countOfPlayerViewController, animated: true)
        
        //        viewModel.calloutViewModel.output.observeCompleted {
        //            [weak self] in
        //            self?.show()
        //        }
        //        viewModel.output.observeCompleted { [weak self] in
        //            self?.navigController?.popViewController(animated: true)
        //            self?._pipe.input.sendCompleted()
        //        }
        navigController?.pushViewController(gameHistoryViewController, animated: true)
        return _pipe.output
    }
    
    func bindViewModel(_ viewModel: GameHistoryViewModelOutputProtocol) {
        viewModel.output.observeValues { [weak self] value in
            switch value {
            case .selectGame(let game):
                self?.gameDidSelect(game)
            }
        }
        
        viewModel.output.observeCompleted { [weak self] in
            self?.navigController?.popViewController(animated: true)
            self?._pipe.input.sendCompleted()
        }
        
    }
    
    func gameDidSelect(_ game: GameHistory) {
                guard let navigController = navigController else { return }
        var playersCoordinator: Optional<PlayersCoordinator> = PlayersCoordinator(navigController, currentGame: game)
                let output = playersCoordinator!.start()
                output.observeCompleted {
                    playersCoordinator = nil
           }
        
        //        let countOfPlayerCoordinator = CountOfPlayerCoordinator(navigController)
        //        countOfPlayerCoordinator.start()
    }
    
    //    func countOfPlayerDidSelect(_ count: Int) {
    //        guard let navController = navController else { return }
    //
    //        var namesOfPlayersCoordinator: Optional<NamesOfPlayersCoordinator> = NamesOfPlayersCoordinator(navController, count)
    //        let output = namesOfPlayersCoordinator!.start()
    //        output.observeCompleted {
    //            namesOfPlayersCoordinator = nil
    //        }
}




extension GameHistoryCoordinator {
    enum Action {
        case selectGame(game: GameHistory)
    }
}

