//
//  PlayersViewModelProtocol .swift
//  Bowling
//
//  Created by Ihar_Karalko on 13.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation
import MapKit
import ReactiveSwift
import Result
import ReactiveCocoa

protocol PlayersViewModelOutputProtocol {
    var output: Signal<Void, NoError> { get }
}

protocol PlayersViewModelProtocol {
    var currentGame: GameHistory { get }
    var playersOfGame: [Player] { get }
    var backCancelAction: Action< Void, Void, NoError>  { get }
 }
