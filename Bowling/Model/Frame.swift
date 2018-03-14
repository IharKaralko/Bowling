//
//  Frame.swift
//  Bowling
//
//  Created by Ihar_Karalko on 16.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation

class Frame {
    
    private var firstScoreFrame: Int?
    private var secondScoreFrame: Int?
    private var thirdScoreFrame: Int?
    
    var isLastFrame: Bool
    private var scoreFrame: Int {
        return throwScore.reduce(0,+) + additionalScore.reduce(0,+)
    }
    private var typeOfFrame: FrameType {
        guard let firstElement = throwScore.first else {return .standart}
        
        if firstElement == 10 {
            return .strike
        }
        if throwScore.count == 2 && throwScore.reduce(0,+) == 10 {
            return  .spare
        }
        return .standart
    }
    private var throwScore: [Int] = []
    private var additionalScore: [Int] = []
    
    init(isLastFrame: Bool) {
        self.isLastFrame = isLastFrame
    }
}

// MARK: - FrameProtocol 
extension Frame: FrameProtocol {
    var score: Int { return scoreFrame }
    var type: FrameType { return typeOfFrame }
    var isLast: Bool { return isLastFrame }
    var firstScore: Int? { return firstScoreFrame }
    var secondScore: Int? { return secondScoreFrame }
    var thirdScore: Int?  { return thirdScoreFrame }
    @discardableResult
    func bowl(with score: Int) -> Bool { return doThrow(with: score) }
    func appendBonus(_ score: Int) { appendAdditionalScore(score) }
}

// MARK: - Public Frame methods
extension Frame {
    func isWaitForAddScore()-> Bool {
        switch self.typeOfFrame {
        case .strike:
            return 2 - additionalScore.count > 0
        case .spare:
            return 1 - additionalScore.count > 0
        default:
            return false
        }
    }
    
    func isOpen() -> Bool {
        switch typeOfFrame {
        case .strike, .spare:
            if isLastFrame {
                return throwScore.count != 3
            } else {
                return false
            }
        default:
            return throwScore.count == 1
        }
    }
}

// MARK: - Private Frame methods
private extension Frame {
    @discardableResult
    func doThrow(with score: Int) -> Bool {
        if throwScore.isEmpty {
            if  -1 < score && score < 11 {
                firstScoreFrame = score
                throwScore.append(score)
                return true
            } else {
                return false
            }
        }
        if !isLastFrame {
            if throwScore.first! + score < 11 {
                secondScoreFrame = score
                throwScore.append(score)
                return true
            } else {
                return false
            }
        } else {
            if throwScore.count == 1 {
                return  doThrowLastFrameSecond(score: score)
            } else {
                return  doThrowLastFrameThird(score: score)
            }
        }
    }
    
    func appendAdditionalScore(_ score: Int) {
        additionalScore.append(score)
    }
    
    func doThrowLastFrameSecond(score: Int) -> Bool {
        if typeOfFrame == .strike {
            secondScoreFrame = score
            throwScore.append(score)
            return true
        } else {
            if throwScore.first! + score < 11 {
                secondScoreFrame = score
                throwScore.append(score)
                return true
            }  else {
                return false
            }
        }
    }
    
    func doThrowLastFrameThird(score: Int) -> Bool {
        if typeOfFrame == .strike {
            if throwScore.reduce(0,+) == 20 {
                thirdScoreFrame = score
                throwScore.append(score)
                return true
            } else if throwScore.reduce(0,+) + score < 21 {
                thirdScoreFrame = score
                throwScore.append(score)
                return true
            }
            return false
        } else if typeOfFrame == .spare {
            thirdScoreFrame = score
            throwScore.append(score)
            return true
        }
        return false
    }
}

// MARK: - Equatable
extension Frame: Equatable {
    static func == (lhs: Frame, rhs: Frame) -> Bool {
        return
            lhs.throwScore == rhs.throwScore
                && lhs.additionalScore == rhs.additionalScore &&
                lhs.typeOfFrame == rhs.typeOfFrame &&
                lhs.isLast == rhs.isLast
    }
}
