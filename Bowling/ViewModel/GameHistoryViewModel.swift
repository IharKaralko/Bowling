//
//  GameHistoryViewModel.swift
//  Bowling
//
//  Created by Ihar_Karalko on 13.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation
import MapKit
import ReactiveCocoa
import ReactiveSwift
import Result

class GameHistoryViewModel {
    
    private var location: Location
    private var _pipe = Signal<GameHistoryCoordinator.Action, NoError>.pipe()
    private var games: [GameHistory]
    private var doneBackAction: Action<Void, Void, NoError>!
    private var serviceDataSourseOfGameHistory: ServiceDataSourseOfGameHistoryProtocol!
    
    init(_ location: Location ) {
        self.location = location
        serviceDataSourseOfGameHistory = ServiceDataSourseOfGameHistory()
        self.games = serviceDataSourseOfGameHistory.getGamesOfCurrentLocation(currentLocationId: location.id)        
        self.doneBackAction = Action() { [weak self]  in
            return SignalProducer { observer, _ in
                self?._pipe.input.sendCompleted()
                observer.sendCompleted()
            }
        }
    }
}

extension GameHistoryViewModel {
    func gameDidSelect(_ currentLocation: GameHistory){
        _pipe.input.send(value: GameHistoryCoordinator.Action.selectGame(game: currentLocation))
    }
}

// MARK: - GameHistoryViewModelProtocol
extension GameHistoryViewModel: GameHistoryViewModelProtocol {
    var backCancelAction: Action< Void, Void, NoError>  { return doneBackAction }
    var currentLocation: Location { return location }
    var gamesHistory: [GameHistory] { return games }
    func selectGameHistory(currentLocation: GameHistory) { return gameDidSelect(currentLocation) }
}

// MARK: - GameHistoryViewModelOutputProtocol
extension GameHistoryViewModel: GameHistoryViewModelOutputProtocol {
    var output: Signal<GameHistoryCoordinator.Action, NoError> { return _pipe.output }
}
