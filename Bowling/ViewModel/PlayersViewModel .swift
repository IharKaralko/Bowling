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
    
    private var game: GameHistory
    private var _pipe = Signal<Void, NoError>.pipe()
    private var players: [Player]
    private var doneBackAction: Action<Void, Void, NoError>!
    private var dataSourceOfPlayer: DataSourceOfPlayerProtocol!
   
    init(_ game: GameHistory ) {
        self.game = game
        dataSourceOfPlayer = DataSourceOfPlayer()
        self.players = dataSourceOfPlayer.getPlayersByGameId(currentGameId: game.id)
        self.doneBackAction = Action() { [weak self]  in
            return SignalProducer { observer, _ in
                self?._pipe.input.sendCompleted()
                observer.sendCompleted()
            }
        }
    }
}

// MARK: - LocationGameViewModelProtocol
extension PlayersViewModel: PlayersViewModelProtocol {
    var backCancelAction: Action< Void, Void, NoError>  { return doneBackAction }
    var currentGame: GameHistory { return game }
    var playersOfGame: [Player] { return players }
}
// MARK: - LocationGameViewModelOutputProtocol
extension  PlayersViewModel: PlayersViewModelOutputProtocol {
    var output: Signal<Void, NoError> { return _pipe.output }
}
