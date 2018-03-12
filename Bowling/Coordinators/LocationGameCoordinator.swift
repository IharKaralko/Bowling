//
//  LocationGameCoordinator.swift
//  Bowling
//
//  Created by Ihar_Karalko on 03.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit
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
    func show() {
        guard let navigController = navigController else { return }
       let countOfPlayerCoordinator = CountOfPlayerCoordinator(navigController)
        countOfPlayerCoordinator.start()
    }
    
}
extension LocationGameCoordinator {
    enum Action {
    case selectLocationOfGame(location: Int)
}
}
