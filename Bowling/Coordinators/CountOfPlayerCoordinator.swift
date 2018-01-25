//
//  CountOfPlayerCoordinator.swift
//  Bowling
//
//  Created by Ihar_Karalko on 18.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit

protocol CountOfPlayerCoordinatorDelegate: class {
    func countOfPlayerCoordinatorDidFinish(_ count: Int)
}

class CountOfPlayerCoordinator { 
    
    deinit {
        print("CountOfPlayerCoordinator deinit")
    }
    var namesOfPlayersCoordinator: NamesOfPlayersCoordinator?
    weak var delegate: CountOfPlayerCoordinatorDelegate?
    private  weak var window: UIWindow?
    var navController: UINavigationController?
    
    init(window: UIWindow) {
        self.window =  window
        
    }
//    init(navController: UINavigationController) {
//        self.navController =  navController
//
//    }
}
extension CountOfPlayerCoordinator {
    
    func start() {
        let countOfPlayerViewController = CountOfPlayerViewController(nibName: "CountOfPlayerView", bundle: nil)
        navController = UINavigationController(rootViewController: countOfPlayerViewController)
        let viewModel = CountOfPlayerViewModel()
        viewModel.coordinatorDelegate = self
        countOfPlayerViewController.viewModel = viewModel
       
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}

extension CountOfPlayerCoordinator: CountOfPlayerViewModelDelegate {
    func countOfPlayerViewModelDidSelect(_ count: Int) {
        namesOfPlayersCoordinator = NamesOfPlayersCoordinator()
      namesOfPlayersCoordinator?.delegate = self
        namesOfPlayersCoordinator?.start(count,  nav: navController!)
        //delegate?.countOfPlayerCoordinatorDidFinish(count)
    }
}
extension CountOfPlayerCoordinator: NamesOfPlayersCoordinatorDelegate {
    func namesOfPlayersCoordinatorDidFinish(collectionOfNames: [String]) {
        print("Get")
        print(collectionOfNames)
        //  namesOfPlayersCoordinator = nil
    }
    
    func namesOfPlayersCoordinatorCancel() {
        if let navController = navController {
            navController.popViewController(animated: true)
        }
    }
    
}
