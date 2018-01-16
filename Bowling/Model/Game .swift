//
//  Game .swift
//  Bowling
//
//  Created by Ihar_Karalko on 16.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation

public class Game :GameProtocol{
    public let maxFrame: Int
    public var scoreGame: Int {
        var score = 0
        frames.forEach({ frame in
            score += frame.scoreFrame
        })
        return score
    }
    public var isOpenGame: Bool {
        return frames.count < maxFrame
    }
    
    private var currentFrame: Frame?
    private var waitingToCloseFrames: [Frame] = []
    private var frames: [Frame] = []
    
    init(maxFrame: Int = 10) {
        self.maxFrame = maxFrame
    }
}

// MARK: - Private Game methods
private extension Game{
    func createFrame() {
        if currentFrame == nil {
            let count = frames.count + waitingToCloseFrames.count
            currentFrame = Frame(isLast: count == maxFrame - 1)
        }
    }
    
    func closeFrame(frame: Frame) {
        let frameType = frame.typeOfFrame
        if ((frameType == .strike || frameType == .spare) && frame.isLast) || frameType == .standart {
            frames.append(frame)
        } else{
            waitingToCloseFrames.append(frame)
        }
        self.currentFrame = nil
    }
    
    func calculateAdditionalScore(with score:Int) {
        var tempArr: [Frame] = []
        
        waitingToCloseFrames.forEach({frame in
            frame.appendAdditionalScore(score)
            if !frame.isWaiteForAddScore() {
                tempArr.append(frame)
            }
        })
        tempArr.forEach {
            frames.append($0)
            if  let index = waitingToCloseFrames.index(of: $0) {
                waitingToCloseFrames.remove(at: index)
            }
        }
    }
}
// MARK: - Internal Game method
extension Game {
    func makeBowl(bowlScore: Int) -> Bool {
        if isOpenGame {
            createFrame()
            if let currentFrame = currentFrame, currentFrame.doThrow(with: bowlScore) {
                calculateAdditionalScore(with:bowlScore)
                if !currentFrame.isOpen() {
                    closeFrame(frame:currentFrame)
                }
                return true
            }
        }
        return false
    }
}
// MARK: - GameProtocol methods
extension Game {
    func gameThrow(bowlScore: Int) -> Bool {
        return makeBowl(bowlScore: bowlScore)
    }
}



