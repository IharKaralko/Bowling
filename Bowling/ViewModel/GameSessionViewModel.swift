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


class GameSessionViewModel {
    
    deinit {
        print("GameSessionViewModel deinit-")
    }
    private let _pipe = Signal<GameSessionViewController.Action, NoError>.pipe()
    private var  doneBackAction: Action<Void, Void, NoError>!
    private let namesOfPlayer: [String]
    private var countOfGameFinish: Int = 0
    private let  gamesModels: [GameViewModel]
    
    init (namesOfPlayer: [String]){
        self.namesOfPlayer  = namesOfPlayer
        var gameModels: [GameViewModel] = []
        for name in namesOfPlayer  {
            let gameViewModel = GameViewModel(nameOfPlayer: name)
            gameModels.append(gameViewModel)
        }
        gamesModels = gameModels
        for i in 0..<namesOfPlayer.count  {
            gamesModels[i].output.observeCompleted {[weak self] in
                self?.stateOfGameChange()
            }          
        }
        self.doneBackAction = Action() { [weak self]  in
            return SignalProducer { observer, _ in
                self?._pipe.input.sendCompleted()
                observer.sendCompleted()
            }
        }
    }
}

private extension GameSessionViewModel {
    func stateOfGameChange() {
        countOfGameFinish += 1
        if countOfGameFinish == namesOfPlayer.count{
            let max = gamesModels.max{$0.currentGame.scoreGame  < $1.currentGame.scoreGame}
            if  let index = gamesModels.index(where: {$0 === max}){
                _pipe.input.send(value: GameSessionViewController.Action.gameSessionCompleted(index: index))
            }
        }
    }
}

// MARK: - GameSessionViewModelProtocol
extension GameSessionViewModel:  GameSessionViewModelProtocol {
    var listNamesOfPlayer: [String] { return  namesOfPlayer }
    var gamesModelsOfGameSession: [GameViewModel] { return gamesModels }
    var output: Signal<GameSessionViewController.Action, NoError> { return _pipe.output }
    var doneCancelAction: Action<Void, Void, NoError> { return  doneBackAction }
}
