//
//  GameSessionCoordinator.swift
//  Bowling
//
//  Created by Ihar_Karalko on 08.02.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result
import ReactiveCocoa

protocol GameSessionCoordinatorProtocol {
    func start() -> Signal<Void, NoError>
}

class GameSessionCoordinator {
    deinit {
        print("GameSessionCoordinator deinit+")
    }
    private weak var navigController: UINavigationController?
    private let _pipe = Signal<Void, NoError>.pipe()
    private let collectionOfNames: [String]
    
    init(_ navigController: UINavigationController, _ collectionOfNames: [String]) {
        self.navigController = navigController
        self.collectionOfNames = collectionOfNames
      }
}

extension GameSessionCoordinator: GameSessionCoordinatorProtocol {
    func start() -> Signal<Void, NoError> {
        return startCoordinator()
    }
}


extension  GameSessionCoordinator {
    func startCoordinator() -> Signal<Void, NoError> {
        let gameSessionViewController = GameSessionViewController()
        let viewModel = GameSessionViewModel(namesOfPlayer: collectionOfNames)
        gameSessionViewController.viewModel = viewModel
        
        viewModel.output.observeCompleted { [weak self] in
            self?.navigController?.popViewController(animated: true)
            self?._pipe.input.sendCompleted()
        }
        navigController?.pushViewController(gameSessionViewController, animated: true)
        return _pipe.output
    }
}



