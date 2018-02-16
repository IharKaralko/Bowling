//
//  GameViewModel.swift
//  Bowling
//
//  Created by Ihar_Karalko on 01.02.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation

 protocol GameViewModelProtocol: class {
    func availableScoreDidChange(_ score: Int)
    func stateOfGameDidChage()
}
protocol GameViewModelStateGame: class {
        func stateOfGameChange()
}

class GameViewModel {
    
    deinit {
        print("GameViewModel deinit")
    }
    
    let nameOfPlayer: String
    let game: Game
    let framesViewModel: [FrameViewModel]
    let finalFrameViewModel: FinalFrameViewModel
    private var frameNumber: Int = 0
    
    weak var delegateGameSession: GameViewModelStateGame?
    weak var delegate: GameViewModelProtocol?
    init(game: Game = Game(maxFrame: 11), nameOfPlayer: String) {
        var frameModels: [FrameViewModel] = []
        for index in 0..<game.maxFrame - 1  {
            let frameViewModel = FrameViewModel(numberOfFrame: index + 1)
            frameModels.append(frameViewModel)
        }
        framesViewModel = frameModels
        finalFrameViewModel = FinalFrameViewModel(numberLastFrame: game.maxFrame)
        self.nameOfPlayer = nameOfPlayer
        self.game = game
        game.delegate = self
    }
}

extension GameViewModel {
    func makeRoll(bowlScore: Int){
        game.makeBowl(bowlScore: bowlScore)
        if game.indexCurrentFrame < framesViewModel.count {
            framesViewModel[game.indexCurrentFrame].frame = game.currentFrameForGame
        } else   {
            finalFrameViewModel.frame = game.currentFrameForGame
        }
        let availableScores = availableButtons(bowlScore)
        delegate?.availableScoreDidChange(availableScores)
        if !game.isOpenGame {
            delegate?.stateOfGameDidChage()
            delegateGameSession?.stateOfGameChange()
          }
    }
}

private extension GameViewModel {
    func availableButtons( _ score: Int)-> Int {  // TODO: Need refactor
        if game.indexCurrentFrame < framesViewModel.count  {
            if (framesViewModel[game.indexCurrentFrame].frame?.isOpen())!{
                return 10 - score + 1
            } else {
                return 10
            }
        } else if game.isOpenGame {
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
}

extension GameViewModel: GameProtocolChangeScoreGame {
    func changeScoreGame(){
        if frameNumber < framesViewModel.count  {                                             
            framesViewModel[frameNumber].scoreGame = game.scoreGame
            frameNumber += 1
        } else {
            finalFrameViewModel.scoreGame = game.scoreGame
        }
    }
}
