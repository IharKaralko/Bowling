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
//protocol GameViewModelProtocol: class {
//    func availableScoreDidChange(_ score: Int)
//    func stateOfGameDidChage()
//}

class GameViewModel {
    
    deinit {
        print("GameViewModel deinit")
    }
    
    let game: Game
    let framesViewModel: [FrameViewModel]
    var finalFrameViewModel: FinalFrameViewModel
    private var frameNumber: Int = 0
   
    
    weak var delegate: GameViewModelProtocol?
    init(game: Game = Game(maxFrame: 4)) {
        var frameModels: [FrameViewModel] = []
        for _ in 0..<game.maxFrame - 1  {
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
        if game.indexCurrentFrame < framesViewModel.count {
            framesViewModel[game.indexCurrentFrame].frame = game.currentFrameForGame
        } else   {
            finalFrameViewModel.frame = game.currentFrameForGame
        }
        let availableScores = activateButton(bowlScore)
        delegate?.availableScoreDidChange(availableScores)
        if !game.isOpenGame {
            delegate?.stateOfGameDidChage()
            
            
          }
    }
}

private extension GameViewModel {
    func activateButton( _ score: Int)-> Int {
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



