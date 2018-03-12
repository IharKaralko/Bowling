//
//  LocationGameCoordinator.swift
//  Bowling
//
//  Created by Ihar_Karalko on 03.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit
import MapKit
import ReactiveSwift
import Result
import ReactiveCocoa

protocol LocationGameCoordinatorProtocol {
    func start() -> Signal<Void, NoError>
}

class LocationGameCoordinator {
    deinit {
        print("LocationGameCoordinator deinit+")
    }
  
    private weak var navigController: UINavigationController?
    private let _pipe = Signal<Void, NoError>.pipe()
   // private let collectionOfNames: [String]

    init(_ navigController: UINavigationController) {
        self.navigController = navigController
      //  self.collectionOfNames = collectionOfNames
    }
}

extension LocationGameCoordinator:  LocationGameCoordinatorProtocol {
    func start() -> Signal<Void, NoError> {
        return startCoordinator()
    }
}


extension  LocationGameCoordinator {
    func startCoordinator() -> Signal<Void, NoError> {
        let locationGameViewController = LocationGameViewController()
      
        
        let viewModel = LocationGameViewModel()
        locationGameViewController.viewModel = viewModel
        
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
        navigController?.pushViewController(locationGameViewController, animated: true)
        return _pipe.output
    }
    
    func bindViewModel(_ viewModel: LocationGameViewModelOutputProtocol) {
        viewModel.output.observeValues { [weak self] value in
            switch value {
            case .selectLocationOfGame(let location):
                self?.locationGameDidSelect(location)
            }
        }
        
        viewModel.output.observeCompleted { [weak self] in
            self?.navigController?.popViewController(animated: true)
            self?._pipe.input.sendCompleted()
        }
        
    }
    
    func locationGameDidSelect(_ location: CLLocationCoordinate2D) {
        guard let navigController = navigController else { return }
       var countOfPlayerCoordinator: Optional<CountOfPlayerCoordinator> = CountOfPlayerCoordinator(navigController, location)
        let output = countOfPlayerCoordinator!.start()
        output.observeCompleted {
            countOfPlayerCoordinator = nil
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
    
    
    

extension LocationGameCoordinator {
    enum Action {
    case selectLocationOfGame(location: CLLocationCoordinate2D)
}
}
