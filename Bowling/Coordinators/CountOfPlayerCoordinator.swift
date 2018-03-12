//
//  CountOfPlayerCoordinator.swift
//  Bowling
//
//  Created by Ihar_Karalko on 18.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit
import MapKit
import ReactiveSwift
import Result
import ReactiveCocoa

protocol CountOfPlayerCoordinatorProtocol {
    func start() -> Signal<CountOfPlayerCoordinator.Output, NoError>
    
}

class CountOfPlayerCoordinator {
    
    private let location: CLLocationCoordinate2D
    private weak var navController: UINavigationController?
    private let _pipe = Signal<CountOfPlayerCoordinator.Output, NoError>.pipe()
    
    init(_ navController: UINavigationController, _ location: CLLocationCoordinate2D) {
        self.navController = navController
        self.location = location
    }
}

// MARK: - CountOfPlayerCoordinatorProtocol
extension CountOfPlayerCoordinator: CountOfPlayerCoordinatorProtocol {
    func start() -> Signal<CountOfPlayerCoordinator.Output, NoError> {
        return startCoordinator()
    }
}

private extension CountOfPlayerCoordinator {
    func startCoordinator()-> Signal<CountOfPlayerCoordinator.Output, NoError> {
        
      // guard let navController = navController else { return }
        
        let countOfPlayerViewController = CountOfPlayerViewController()
        let viewModel = CountOfPlayerViewModel()
        countOfPlayerViewController.viewModel = viewModel
        
        bindViewModel(viewModel)
        navController?.pushViewController(countOfPlayerViewController, animated: true)
        
        return _pipe.output
        
        // navController.viewControllers = [countOfPlayerViewController]
    }
    
    func bindViewModel(_ viewModel: CountOfPlayerOutputProtocol) {
        viewModel.output.observeValues { [weak self] value in
            switch value {
            case .inputCountOfPlayers(let count):
 
                self?.countOfPlayerDidSelect(count)
            }
        }
        
        viewModel.output.observeCompleted { [weak self] in
            self?.navController?.popViewController(animated: true)
            self?._pipe.input.sendCompleted()
            
        }
    }
    
    func make(){ print ("Make")}
    
    
    func countOfPlayerDidSelect(_ count: Int) {
        guard let navController = navController else { return }

        var namesOfPlayersCoordinator: Optional<NamesOfPlayersCoordinator> = NamesOfPlayersCoordinator(navController, count, location)
        let output = namesOfPlayersCoordinator!.start()
        output.observeCompleted {
            namesOfPlayersCoordinator = nil
        }
    }
}


extension CountOfPlayerCoordinator {
    enum Action {
        case inputCountOfPlayers(count: Int)
    }
    enum Output {
    }
    
}
