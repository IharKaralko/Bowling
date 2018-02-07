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
    var finalFrameViewModel: FinalFrameViewModel = FinalFrameViewModel()
    var frameNumber: Int = 0
    
    weak var delegate: GameViewModelProtocol?
    
    init(game: Game = Game(maxFrame: 4)) {
        var frameModels: [FrameViewModel] = []
        for _ in 0..<game.maxFrame {
            let frameViewModel = FrameViewModel()
            frameModels.append(frameViewModel)
        }
        framesViewModel = frameModels
        self.game = game
        game.delegate = self
    }
}

private extension GameViewModel {
}

extension GameViewModel {
    func makeRoll(bowlScore: Int){
        game.makeBowl(bowlScore: bowlScore)
        if game.indexCurrentFrame < framesViewModel.count {
            framesViewModel[game.indexCurrentFrame].frame = game.currentFrameForGame
        } else   {
            finalFrameViewModel.frame = game.currentFrameForGame
        }
        let availableScores = activateButton(bowlScore)
        delegate?.availableScoreDidChange(availableScores)
    }
    
    func activateButton( _ score: Int)-> Int {
        if game.indexCurrentFrame < framesViewModel.count {
            if (framesViewModel[game.indexCurrentFrame].frame?.isOpen())!{
                return 10 - score + 1
            } else {
                return 10
            }
        }
        return 10
    }
}

extension GameViewModel: GameProtocolScoreGame {
     func changeScoreGame(){
        if frameNumber < framesViewModel.count {
        framesViewModel[frameNumber].scoreGame = game.scoreGame
        frameNumber += 1
        }
    }
}



