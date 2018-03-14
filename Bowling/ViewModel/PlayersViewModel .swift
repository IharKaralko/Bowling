//
//  PlayersViewModel .swift
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

class PlayersViewModel {
    
    var game: GameHistory
    private var _pipe = Signal<Void, NoError>.pipe()
    var players: [Player]
    
    init(_ game: GameHistory ){
        self.game = game
        let servicePlayer = ServicePlayer()
        self.players = servicePlayer.getPlayersOfGameHistory(currentGameId: game.id)
    }
}


// MARK: - LocationGameViewModelProtocol
extension PlayersViewModel: PlayersViewModelProtocol {
    var currentGame: GameHistory { return game }
    var playersOfGame: [Player] { return players }
}
// MARK: - LocationGameViewModelOutputProtocol
extension  PlayersViewModel: PlayersViewModelOutputProtocol {
    var output: Signal<Void, NoError> { return _pipe.output }
}
