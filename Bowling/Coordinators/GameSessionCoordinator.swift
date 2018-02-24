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

class GameSessionCoordinator {
    deinit {
        print("GameSessionCoordinator deinit+")
    }
    private weak var navigController: UINavigationController?
    private let _pipe = Signal<Void, NoError>.pipe()
    init(_ navigController: UINavigationController) {
        self.navigController = navigController
    }
}

extension  GameSessionCoordinator {
    func start(_ collectionOfNames: [String])-> Signal<Void, NoError>{
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



