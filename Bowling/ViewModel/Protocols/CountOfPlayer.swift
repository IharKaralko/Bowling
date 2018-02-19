//
//  CountOfPlayer.swift
//  Bowling
//
//  Created by Ihar_Karalko on 17.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result
import ReactiveCocoa

protocol CountOfPlayerViewModelDelegate: class {
    func countOfPlayerViewModelDidSelect(_ count: Int)
}
protocol CountOfPlayer {
    
    
    var inputNumbersOfPlayers: Action<(String?), Void, NoError>! { get set }
    var correctNumber: Bool! {get set }
    var inputText:  MutableProperty<String?> {get set }
    var numbersOfPlayer: Int { get set }
    var coordinatorDelegate: CountOfPlayerViewModelDelegate? { get set }
    func acceptCountOfPlayers(count: Int)
}
