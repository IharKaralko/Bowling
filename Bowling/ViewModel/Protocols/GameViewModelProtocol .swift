//
//  GameViewModelProtocol .swift
//  Bowling
//
//  Created by Ihar_Karalko on 01.02.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result
import ReactiveCocoa

protocol GameViewModelProtocol {
    var idCurrentGame: String { get }
    var nameOfPlayerCurrentGame: String { get }
    var player: Player { get }
    var currentGame: Game { get }
    var collectionFramesViewModel: [FrameViewModel] { get }
    var currentFinalFrameViewModel: FinalFrameViewModel { get }
    var output: Signal<GameView.Action, NoError> { get }
    func makeBowl(bowlScore: Int)
    
}
