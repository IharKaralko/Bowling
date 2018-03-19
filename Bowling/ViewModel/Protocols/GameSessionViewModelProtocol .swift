//
//  GameSessionViewModelProtocol .swift
//  Bowling
//
//  Created by Ihar_Karalko on 01.02.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation
import ReactiveCocoa
import ReactiveSwift
import Result

protocol GameSessionViewModelProtocol {
      var gamesModelsOfGameSession: [GameViewModel] { get }
    var output: Signal<GameSessionViewController.Action, NoError> { get }
    var doneCancelAction: Action<Void, Void, NoError> { get }
    var configurationCurrentGame: ConfigurationGame { get }
    var dataSourceOfPlayer: DataSourceOfPlayerProtocol { get }
    func refreshScoreGameOfPlayers()
}



