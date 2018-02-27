//
//  GameViewModel.swift
//  Bowling
//
//  Created by Ihar_Karalko on 01.02.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result
import ReactiveCocoa

class GameViewModel {
    
    deinit {
        print("GameViewModel deinit")
    }
    
    private let nameOfPlayer: String
    private let game: Game
    private let framesViewModel: [FrameViewModel]
    private let finalFrameViewModel: FinalFrameViewModel
    private var frameNumber: Int = 0
    private var _pipe = Signal<GameView.Action, NoError>.pipe()
    
    
    init(game: Game = Game(), nameOfPlayer: String) {
        var frameModels: [FrameViewModel] = []
        for index in 0..<game.maxFrame - 1  {
            let frameViewModel = FrameViewModel(numberOfFrame: index + 1)
            frameModels.append(frameViewModel)
        }
        framesViewModel = frameModels
        finalFrameViewModel = FinalFrameViewModel(numberLastFrame: game.maxFrame)
        self.nameOfPlayer = nameOfPlayer
        self.game = game
        game.output.observeValues { [weak self] in
            self?.changeScoreGame()
          }
    }
}
// MARK: - private methods
private extension GameViewModel {
    func makeRoll(bowlScore: Int){
        game.makeBowl(bowlScore: bowlScore)
        if game.indexCurrentFrame < framesViewModel.count {
            framesViewModel[game.indexCurrentFrame].frame = game.currentFrameForGame
        } else   {
            finalFrameViewModel.frame = game.currentFrameForGame
        }
        let availableScores = availableButtons(bowlScore)
            _pipe.input.send(value: GameView.Action.trowDidEnding(score: availableScores))
          if !game.isOpen {
             _pipe.input.sendCompleted()
          }
    }

    func availableButtons( _ score: Int)-> Int {
        if game.indexCurrentFrame < framesViewModel.count  {
            if (framesViewModel[game.indexCurrentFrame].frame?.isOpen())!{
                return 10 - score + 1
            } else {
                return 10
            }
        } else if game.isOpen {
            if let summSecond = finalFrameViewModel.frame?.secondScore {
                let summ = (finalFrameViewModel.frame?.firstScore)! + summSecond
                if summ == 20 || summ == 10 {
                    return  10
                } else { return 10 - score +  1 }
            } else {
                if let summFirst = finalFrameViewModel.frame?.firstScore {
                    if summFirst < 10 && summFirst > 0 {
                        return 10 - score +  1
                    } else { return 10 }
                } else { return 10 }
            }
        } else {return 0 }
    }
    
    func changeScoreGame() {
        if frameNumber < framesViewModel.count  {                                             
            framesViewModel[frameNumber].scoreGame = game.score
            frameNumber += 1
        } else {
            finalFrameViewModel.scoreGame = game.score
        }
    }
}

// MARK: - GameViewModelProtocol
extension GameViewModel: GameViewModelProtocol {
    var nameOfPlayerCurrentGame: String { return nameOfPlayer }
    var currentGame: Game { return game }
    var collectionFramesViewModel: [FrameViewModel] { return framesViewModel }
    var currentFinalFrameViewModel: FinalFrameViewModel { return finalFrameViewModel }
    var output: Signal<GameView.Action, NoError> { return  _pipe.output}
    
    func makeBowl(bowlScore: Int){
        makeRoll(bowlScore: bowlScore)
    }
}
