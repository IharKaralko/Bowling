//
//  ShowListOfNameCoordinator .swift
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

protocol NamesOfPlayersCoordinatorProtocol {
    func start() -> Signal<NamesOfPlayersCoordinator.Output, NoError>
}

class NamesOfPlayersCoordinator {
    
    deinit {
        print("NamesOfPlayersCoordinator deinit")
    }
    
    private let location: CLLocationCoordinate2D
    private weak var navigationController: UINavigationController?
    private let _pipe = Signal<NamesOfPlayersCoordinator.Output, NoError>.pipe()
    private let countOfPlayers: Int
    
    init(_ navigationController: UINavigationController, _ countOfPlayers: Int, _ location: CLLocationCoordinate2D){
        self.navigationController = navigationController
        self.countOfPlayers = countOfPlayers
        self.location = location
    }
}

extension NamesOfPlayersCoordinator: NamesOfPlayersCoordinatorProtocol {
    func start() -> Signal<NamesOfPlayersCoordinator.Output, NoError> {
        return startCoordinator()
    }
}

private extension NamesOfPlayersCoordinator {
    func startCoordinator() -> Signal<NamesOfPlayersCoordinator.Output, NoError> {
        let namesOfPlayersViewController = NamesOfPlayersViewController()
        let viewModel = NamesOfPlayersViewModel(countOfPlayers: countOfPlayers)
        namesOfPlayersViewController.viewModel = viewModel
        
        viewModel.output.observeValues { [weak self] value in
            switch value {
            case .namesOfPlayersDidSelect(let names):
                self?.namesOfPlayersDidSelect(names)
            }
        }
        viewModel.output.observeCompleted { [weak self] in
            self?.navigationController?.popViewController(animated: true)
            self?._pipe.input.sendCompleted()
        }
        navigationController?.pushViewController(namesOfPlayersViewController, animated: true)
        return _pipe.output
    }
    
    func namesOfPlayersDidSelect(_ collectionOfNames: [String]) {
        guard let navigationController = navigationController else { return }
        
        var gameSessionCoordinator: Optional<GameSessionCoordinator> = GameSessionCoordinator(navigationController, collectionOfNames)
        let output = gameSessionCoordinator!.start()
        output.observeCompleted {
            gameSessionCoordinator = nil
        }
    }
//    func namesOfPlayersDidSelect(_ collectionOfNames: [String]) {
//        guard let navigationController = navigationController else { return }
//
//        var locationGameCoordinator: Optional<LocationGameCoordinator> = LocationGameCoordinator(navigationController, collectionOfNames)
//        let output = locationGameCoordinator!.start()
//        output.observeCompleted {
//            locationGameCoordinator = nil
//        }
//    }
}

extension NamesOfPlayersCoordinator {
    enum Action {
        case namesOfPlayersDidSelect(names: [String])
    }
    enum Output {
    }
}
