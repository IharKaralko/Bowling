//
//  GameSessionViewModel.swift
//  Bowling
//
//  Created by Ihar_Karalko on 01.02.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation
import ReactiveCocoa
import ReactiveSwift
import Result

protocol GameSessionViewModelStateGame: class {
    func alertGameSessionCompleted(_ index: Int)
}


class GameSessionViewModel {
    
    deinit {
        print("GameSessionViewModel deinit----------------------")
    }
    
    private var _pipe = Signal<Void, NoError>.pipe()
     var doneBackAction: Action<Void, Void, NoError>!
    
    
    weak var delegate: GameSessionViewModelStateGame?
    
    var namesOfPlayer: [String]  // TODO: Need refactor
   // weak var coordinatorDelegate: GameSessionViewModelDelegate?
    var countOfGameFinish: Int = 0
    let gamesModels: [GameViewModel]
    
    init (namesOfPlayer: [String]){
        
        
        
        self.namesOfPlayer  = namesOfPlayer
        var gameModels: [GameViewModel] = []
        for name in namesOfPlayer  {
            let gameViewModel = GameViewModel(nameOfPlayer: name)
            gameModels.append(gameViewModel)
        }
        gamesModels = gameModels
        for i in 0..<namesOfPlayer.count  {
            gamesModels[i].delegateGameSession = self
        }
        
        self.doneBackAction = Action() { [weak self]  in
            return SignalProducer { observer, _ in
                self?._pipe.input.sendCompleted()
                observer.sendCompleted()
            }
        }
        
    }
}

// MARK: - CountOfPlayer protocol
//extension GameSessionViewModel: GameSessionViewModelProtocol {
//        func doneBack() {
//        coordinatorDelegate?.gameSessionViewModelDoneBack()
//    }
//}
extension GameSessionViewModel: GameViewModelStateGame {
    func stateOfGameChange() {
        countOfGameFinish += 1
        if countOfGameFinish == namesOfPlayer.count{
            let max = gamesModels.max{$0.game.scoreGame  < $1.game.scoreGame}
            print("Bardzo")
            if  let index = gamesModels.index(where: {$0 === max}){
                delegate?.alertGameSessionCompleted(index)
            }
        }
    }
}

// MARK: - NamesOfPlayersCoordinatorProtocol
extension GameSessionViewModel: GameSessionOutputProtocol {
    var output: Signal<Void, NoError> { return _pipe.output }
}
