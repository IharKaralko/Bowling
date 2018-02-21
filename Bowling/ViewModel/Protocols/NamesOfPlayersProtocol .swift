//
//  NamesOfPlayers .swift
//  Bowling
//
//  Created by Ihar_Karalko on 24.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result
import ReactiveCocoa

protocol NamesOfPlayersOutputProtocol {
    var output: Signal<NamesOfPlayersCoordinator.Action, NoError> { get }
}

protocol NamesOfPlayersProtocol {
    var numberOfPlayers: Int { get }
    var namesOfPlayersAction: Action< [String], Void, NoError> { get }
    var backCancelAction: Action< Void, Void, NoError>  { get }
}
