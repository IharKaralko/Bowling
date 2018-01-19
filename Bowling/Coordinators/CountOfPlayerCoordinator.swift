//
//  CountOfPlayerCoordinator.swift
//  Bowling
//
//  Created by Ihar_Karalko on 18.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit

protocol CountOfPlayerCoordinatorDelegate: class {
    func countOfPlayerCoordinatorDidFinish(coordinator: CountOfPlayerCoordinator)
}

class CountOfPlayerCoordinator: Coordinator {
    
    deinit {
        print("CountOfPlayerCoordinator deinit")
    }
    
    weak var delegate: CountOfPlayerCoordinatorDelegate?
    weak var window: UIWindow?
    
    init(window: UIWindow) {
        self.window =  window
        
    }
    
    func start() {
        let countOfPlayerViewController = CountOfPlayerViewController(nibName: "CountOfPlayerView", bundle: nil)
        let viewModel = CountOfPlayerViewModel()
        viewModel.coordinatorDelegate = self
        countOfPlayerViewController.viewModel = viewModel
        
        window?.rootViewController = countOfPlayerViewController
        window?.makeKeyAndVisible()
    }
}

extension CountOfPlayerCoordinator: CountOfPlayerViewModelDelegate {
    func countOfPlayerViewModelDidSelect(_ viewModel: CountOfPlayer) {
        delegate?.countOfPlayerCoordinatorDidFinish(coordinator: self)
    }
}
