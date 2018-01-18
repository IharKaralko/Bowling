//
//  ShowListOfNameCoordinator .swift
//  Bowling
//
//  Created by Ihar_Karalko on 18.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit

protocol NamesOfPlayersCoordinatorDelegate: class
{
    func NamesOfPlayersCoordinatorDidFinish(showListOfNameCoordinator: NamesOfPlayersCoordinator)
}

class NamesOfPlayersCoordinator: Coordinator
{
    weak var delegate: NamesOfPlayersCoordinatorDelegate?
    let window: UIWindow
    
    init(window: UIWindow)
    {
        self.window = window
    }
    
    func start()
    {
        let namesOfPlayersViewController = NamesOfPlayersViewController(nibName: "NamesOfPlayersView", bundle: nil)
     //   let viewModel = NamesOfPlayersViewModel()
       // namesOfPlayersViewController.viewModel = viewModel
        
        window.rootViewController = namesOfPlayersViewController
        window.makeKeyAndVisible()
        
    }
}
