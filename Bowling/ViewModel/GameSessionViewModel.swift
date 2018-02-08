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
    
    weak var coordinatorDelegate: GameSessionViewModelDelegate?
}

// MARK: - CountOfPlayer protocol
extension GameSessionViewModel: GameSessionViewModelProtocol {
    func doneBack() {
        coordinatorDelegate?.gameSessionViewModelDoneBack()
    }
}
