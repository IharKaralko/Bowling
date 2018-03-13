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
    
    var location: Location
    private var _pipe = Signal<GameHistoryCoordinator.Action, NoError>.pipe()
    var games: [GameHistory]
    
    init(_ location: Location ){
        self.location = location
        let serviceGameHistory = ServiceGameHistory()
        self.games = serviceGameHistory.getGamesOfLocation(currentLocationId: location.id!)
    }
}
extension GameHistoryViewModel {
    func gameDidSelect(_ currentLocation: GameHistory){
          _pipe.input.send(value: GameHistoryCoordinator.Action.selectGame(game: currentLocation))
        
    }
}

// MARK: - LocationGameViewModelProtocol
extension GameHistoryViewModel: GameHistoryViewModelProtocol {
    var currentLocation: Location { return location }
    var gamesHistory: [GameHistory] { return games }
    func selectGameHistory(currentLocation: GameHistory){
        return gameDidSelect(currentLocation)
        
    }
    
}
// MARK: - LocationGameViewModelOutputProtocol
extension GameHistoryViewModel: GameHistoryViewModelOutputProtocol {
    var output: Signal<GameHistoryCoordinator.Action, NoError> { return _pipe.output }
}
