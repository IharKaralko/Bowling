//
//  CountOfPlayerCoordinator.swift
//  Bowling
//
//  Created by Ihar_Karalko on 18.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit

protocol CountOfPlayerCoordinatorDelegate: class
{
    func CountOfPlayerCoordinatorDidFinish(countOfPlayerCoordinator: CountOfPlayerCoordinator)
}

class CountOfPlayerCoordinator: Coordinator
{
    weak var delegate: CountOfPlayerCoordinatorDelegate?
    let window: UIWindow
    
    init(window: UIWindow)
    {
        self.window = window
    }
    
    func start()
    {
        let countOfPlayerViewController = CountOfPlayerViewController(nibName: "CountOfPlayerView", bundle: nil)
        let viewModel = CountOfPlayerViewModel()
        countOfPlayerViewController.viewModel = viewModel
        
        window.rootViewController = countOfPlayerViewController
        window.makeKeyAndVisible()
        
    }
}

