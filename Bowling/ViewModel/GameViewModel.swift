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
}

class GameViewModel {
    let game: Game
    let framesViewModel: [FrameViewModel]
    var finalFrameViewModel: FinalFrameViewModel
    private var frameNumber: Int = 0
    
    weak var delegate: GameViewModelProtocol?
    
    init(game: Game = Game(maxFrame: 4)) {
        var frameModels: [FrameViewModel] = []
        for _ in 0..<game.maxFrame {
            let frameViewModel = FrameViewModel()
            frameModels.append(frameViewModel)
        }
        framesViewModel = frameModels
        finalFrameViewModel = FinalFrameViewModel()
        self.game = game
        game.delegate = self
    }
}

extension GameViewModel {
    func makeRoll(bowlScore: Int){
        game.makeBowl(bowlScore: bowlScore)
        if game.indexCurrentFrame < framesViewModel.count - 1{
            framesViewModel[game.indexCurrentFrame].frame = game.currentFrameForGame
        } else   {
            finalFrameViewModel.frame = game.currentFrameForGame
        }
        let availableScores = activateButton(bowlScore)
        delegate?.availableScoreDidChange(availableScores)
    }
}

private extension GameViewModel {
    func activateButton( _ score: Int)-> Int {
        if game.indexCurrentFrame < framesViewModel.count - 1 {
            if (framesViewModel[game.indexCurrentFrame].frame?.isOpen())!{
                return 10 - score + 1
            } else {
                return 10
            }
        } else {
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
        }
    }
}

extension GameViewModel: GameProtocolScoreGame {
    func changeScoreGame(){
        if frameNumber < framesViewModel.count - 1 {
            framesViewModel[frameNumber].scoreGame = game.scoreGame
            frameNumber += 1
        } else {
            finalFrameViewModel.scoreGame = game.scoreGame
        }
    }
}



