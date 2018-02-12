//
//  GameSessionViewModel.swift
//  Bowling
//
//  Created by Ihar_Karalko on 01.02.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation

class GameSessionViewModel {
    
    deinit {
        print("GameSessionViewModel deinit")
    }
    var names: [String]  // TODO: Need refactor
    weak var coordinatorDelegate: GameSessionViewModelDelegate?
    var countOfGameFinish: Int = 0
    let gamesModels: [GameViewModel]
    
    init (names: [String]){
        self.names  = names
        
        var gameModels: [GameViewModel] = []
        for _ in 0..<names.count  {
            let gameViewModel = GameViewModel()
            gameModels.append(gameViewModel)
        }
          gamesModels = gameModels
    }
}

// MARK: - CountOfPlayer protocol
extension GameSessionViewModel: GameSessionViewModelProtocol {
    func doneBack() {
        coordinatorDelegate?.gameSessionViewModelDoneBack()
    }
}
