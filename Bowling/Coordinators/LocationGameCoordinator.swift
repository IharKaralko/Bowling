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
        print("\(type(of: self)).\(#function)")
    }
    
    private weak var navigController: UINavigationController?
    private let _pipe = Signal<Void, NoError>.pipe()
   
    init(_ navigController: UINavigationController) {
        self.navigController = navigController
    }
}

extension LocationGameCoordinator:  LocationGameCoordinatorProtocol {
    func start() -> Signal<Void, NoError> {
        return startCoordinator()
    }
}


extension  LocationGameCoordinator {
    func startCoordinator() -> Signal<Void, NoError> {
        guard let navigController = navigController else { return .empty }
        let locationGameViewController = LocationGameViewController()
        let viewModel = LocationGameViewModel()
        locationGameViewController.viewModel = viewModel
        bindViewModel(viewModel)
        navigController.pushViewController(locationGameViewController, animated: true)
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
    }
}

extension LocationGameCoordinator {
    enum Action {
        case selectLocationOfGame(location: CLLocationCoordinate2D)
    }
}
