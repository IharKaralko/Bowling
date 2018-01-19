//
//  CountOfPlayer.swift
//  Bowling
//
//  Created by Ihar_Karalko on 17.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation

protocol CountOfPlayerViewModelDelegate: class {
    func countOfPlayerViewModelDidSelect(_ viewModel: CountOfPlayer)
}
protocol CountOfPlayer {
    
    var numbersOfPlayer: Int { get set }
    var coordinatorDelegate: CountOfPlayerViewModelDelegate? { get set}
    func acceptCountOfPlayers(count: Int)
    
}
