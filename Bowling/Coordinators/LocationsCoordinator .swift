//
//  LocationsCoordinator .swift
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

protocol LocationsCoordinatorProtocol {
    func start() -> Signal<Void, NoError>
}

class LocationsCoordinator {
    deinit {
        print("LocationsCoordinator deinit+")
    }
    
    private weak var navigController: UINavigationController?
    private let _pipe = Signal<Void, NoError>.pipe()
    // private let collectionOfNames: [String]
    
    init(_ navigController: UINavigationController) {
        self.navigController = navigController
        //  self.collectionOfNames = collectionOfNames
    }
}

extension LocationsCoordinator:  LocationsCoordinatorProtocol {
    func start() -> Signal<Void, NoError> {
        return startCoordinator()
    }
}


extension  LocationsCoordinator {
    func startCoordinator() -> Signal<Void, NoError> {
        let locationsViewController = LocationsViewController()
        
        
        let viewModel = LocationsViewModel()
       // viewModel.
        locationsViewController.viewModel = viewModel
        
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
        navigController?.pushViewController(locationsViewController, animated: true)
        return _pipe.output
    }
    
    func bindViewModel(_ viewModel: LocationsViewModelOutputProtocol) {
        viewModel.output.observeValues { [weak self] value in
            switch value {
            case .selectLocation(let location):
                self?.locationGameDidSelect(location)
            case .clearHistory:
                self?.startCoordinator()
                
            }
        }
        
        viewModel.output.observeCompleted { [weak self] in
            self?.navigController?.popViewController(animated: true)
            self?._pipe.input.sendCompleted()
        }
        
    }
    
    func locationGameDidSelect(_ location: Location) {
        guard let navigController = navigController else { return }
        var gameHistoryCoordinator: Optional<GameHistoryCoordinator> = GameHistoryCoordinator(navigController, location)
       let output = gameHistoryCoordinator!.start()
        output.observeCompleted {
            gameHistoryCoordinator = nil
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




extension LocationsCoordinator {
    enum Action {
        case selectLocation(location: Location)
        case clearHistory
    }
}

