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
import CoreLocation
import MapKit

class GameSessionViewModel {
    
    deinit {
        print("GameSessionViewModel deinit-")
    }
    private let _pipe = Signal<GameSessionViewController.Action, NoError>.pipe()
    private var  doneBackAction: ReactiveSwift.Action<Void, Void, NoError>!
    private var  countOfGameFinish: Int = 0
    private let  gamesModels: [GameViewModel]
    private let  configurationGame: ConfigurationGame
    private var dataSourcePlayers: DataSourceOfPlayerProtocol!
  
    
    
    init (configurationGame: ConfigurationGame) {
      
        self.configurationGame = configurationGame
        var gameModels: [GameViewModel] = []
        for name in configurationGame.namesOfPlayer  {
            let gameViewModel = GameViewModel(nameOfPlayer: name)
            gameModels.append(gameViewModel)
        }
        gamesModels = gameModels
        for i in 0..<configurationGame.namesOfPlayer.count  {
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
        dataSourcePlayers = DataSourceOfPlayer()
        dataSourcePlayers.savePlayersOfGame(configurationGame: configurationGame)
      }
}

private extension GameSessionViewModel {
      func updateScoreGameOfPlayers(){
        dataSourcePlayers.updateScoreGamePlayers(idGameSession: configurationCurrentGame.idGameSession, gamesModels: gamesModelsOfGameSession)
      }
    
    
    func stateOfGameChange() {
        countOfGameFinish += 1
        if countOfGameFinish == configurationGame.namesOfPlayer.count{
            let max = gamesModels.max{$0.currentGame.score  < $1.currentGame.score}
            if  let index = gamesModels.index(where: {$0 === max}){
                _pipe.input.send(value: GameSessionViewController.Action.gameSessionCompleted(index: index))
            }
           updateScoreGameOfPlayers()
         }
    }
}


// MARK: - GameSessionViewModelProtocol
extension GameSessionViewModel:  GameSessionViewModelProtocol {
    var configurationCurrentGame: ConfigurationGame { return configurationGame }
    var gamesModelsOfGameSession: [GameViewModel] { return gamesModels }
    var output: Signal<GameSessionViewController.Action, NoError> { return _pipe.output }
    var doneCancelAction: ReactiveSwift.Action<Void, Void, NoError> { return  doneBackAction }
    var dataSourceOfPlayer: DataSourceOfPlayerProtocol { return dataSourcePlayers}
    func refreshScoreGameOfPlayers(){ updateScoreGameOfPlayers() }
}

extension GameSessionViewModel {
    enum Action {
        case locationGameDidSelect(location: String)
    }
}
