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

protocol CountOfPlayerOutputProtocol {
    var output: Signal<CountOfPlayerCoordinator.Action, NoError> { get }
}

protocol CountOfPlayerProtocol {
    var getNumbersOfPlayersAction: Action<Int, Void, NoError> { get }
    var numberOfPlayers:  Int { get }
}
