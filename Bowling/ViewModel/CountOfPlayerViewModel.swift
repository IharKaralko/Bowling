//
//  CountOfPlayerViewModel.swift
//  Bowling
//
//  Created by Ihar_Karalko on 17.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation

class CountOfPlayerViewModel {
    
    var numbersOfPlayer: Int
    weak var coordinatorDelegate: CountOfPlayerViewModelDelegate?
    init(numbersOfPlayer: Int = 10) {
        self.numbersOfPlayer = numbersOfPlayer
    }
}
// MARK: - CountOfPlayer protocol
extension CountOfPlayerViewModel: CountOfPlayer {
    func acceptCountOfPlayers(count: Int) {
        numbersOfPlayer = count
        coordinatorDelegate?.countOfPlayerViewModelDidSelect(self) 
    }
}


