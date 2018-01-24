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
    func namesOfPlayersCoordinatorDidFinish(collectionOfNames: [String])
}

class NamesOfPlayersCoordinator 
{
    weak var delegate: NamesOfPlayersCoordinatorDelegate?
    let window: UIWindow
    
    init(window: UIWindow)
    {
        self.window = window
    }
    
    func start(_ count: Int)
    {
        let namesOfPlayersViewController = NamesOfPlayersViewController(nibName: "NamesOfPlayersView", bundle: nil)
        namesOfPlayersViewController.countPlayers = count
        let viewModel = NamesOfPlayersViewModel()
        viewModel.coordinatorDelegate = self
        namesOfPlayersViewController.viewModel = viewModel
        
        window.rootViewController = namesOfPlayersViewController
        window.makeKeyAndVisible()
        
    }
}
extension NamesOfPlayersCoordinator: NamesOfPlayersViewModelDelegate {
    func namesOfPlayersViewModelDidSelect(_ collectionOfNames: [String]) {
        delegate?.namesOfPlayersCoordinatorDidFinish(collectionOfNames: collectionOfNames)
    }
}
