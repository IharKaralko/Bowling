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
    
    private let id: String
    private let _pipe = Signal<GameSessionViewController.Action, NoError>.pipe()
    private var  doneBackAction: ReactiveSwift.Action<Void, Void, NoError>!
    private let namesOfPlayer: [String]
    private var countOfGameFinish: Int = 0
    private let  gamesModels: [GameViewModel]
    
    
 //   let locationGame: LocationGameViewModel = LocationGameViewModel()
    
    init (namesOfPlayer: [String]){
        self.namesOfPlayer  = namesOfPlayer
        self.id = UUID().uuidString
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
        self.doneBackAction = ReactiveSwift.Action() { [weak self]  in
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
            let max = gamesModels.max{$0.currentGame.score  < $1.currentGame.score}
            if  let index = gamesModels.index(where: {$0 === max}){
                _pipe.input.send(value: GameSessionViewController.Action.gameSessionCompleted(index: index))
                
//                locationGame.output.observeValues({ [weak self] value in
//                    switch value {
//                    case .locationGameDidSelect(let location):
//                        let serviceLocation = ServiceLocation()
//                        serviceLocation.create(location: location)
//                        //self?.namesOfPlayersDidSelect(names)
//                    }
//                })
            }
        }
    }
}

// MARK: - GameSessionViewModelProtocol
extension GameSessionViewModel:  GameSessionViewModelProtocol {
    
    var idCurrentGameSession: String { return id }
    var listNamesOfPlayer: [String] { return  namesOfPlayer }
    var gamesModelsOfGameSession: [GameViewModel] { return gamesModels }
    var output: Signal<GameSessionViewController.Action, NoError> { return _pipe.output }
    var doneCancelAction: ReactiveSwift.Action<Void, Void, NoError> { return  doneBackAction }
}

extension GameSessionViewModel {
    enum Action {
        case locationGameDidSelect(location: String)
    }
}
