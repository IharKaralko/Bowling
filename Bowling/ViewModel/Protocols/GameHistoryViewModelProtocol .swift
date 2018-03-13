//
//  GameHistoryViewModelProtocol .swift
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

protocol GameHistoryViewModelOutputProtocol {
    var output: Signal<GameHistoryCoordinator.Action, NoError> { get }
}

protocol GameHistoryViewModelProtocol {
    var currentLocation: Location { get }
    var gamesHistory: [GameHistory] { get }
    func selectGameHistory(currentLocation: GameHistory)
}
