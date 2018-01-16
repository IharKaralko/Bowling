//
//  Frame.swift
//  Bowling
//
//  Created by Ihar_Karalko on 16.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation

enum FrameType: Int {
    case standart
    case spare
    case strike
}
class Frame: FrameProtocol {
    var isLast: Bool                   //let?
    var scoreFrame: Int {
        return throwScore.reduce(0,+) + additionalScore.reduce(0,+)
    }
    var typeOfFrame: FrameType {
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
    
    init(isLast: Bool) {
        self.isLast = isLast
    }
}

// MARK: - FrameProtocol methods
extension Frame {
    func frameThrow(with score: Int) -> Bool {
        return doThrow(with: score)
    }
    
    func frameAppendAdditionalScore(_ score: Int) {
        appendAdditionalScore(score)
    }
    
    func frameIsWaiteForAddScore()-> Bool{
        return isWaiteForAddScore()
    }
    func frameIsOpen() -> Bool{
        return isOpen()
    }
}

// MARK: - Public Frame methods
extension Frame {
    func doThrow(with score: Int) -> Bool {
        if throwScore.isEmpty {
            throwScore.append(score)
            return true
        }
        if !isLast {                                          //!isLast
            if throwScore.first! + score < 11 {
                throwScore.append(score)
                return true
            } else {
                return false
            }
        } else {                                                   //isLast
            if throwScore.count == 1 {                                 //One throw
                return  doThrowLastFrameSecond(score: score)
            } else {                                                //second throw
                return  doThrowLastFrameThird(score: score)
            }
        }
    }
    
    func appendAdditionalScore(_ score: Int) {
        additionalScore.append(score)
    }
    
    func isWaiteForAddScore()-> Bool {
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
            if isLast {
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
    func doThrowLastFrameSecond(score: Int) -> Bool {
        if typeOfFrame == .strike {
            throwScore.append(score)
            return true
        } else {
            if throwScore.first! + score < 11 {
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
                throwScore.append(score)
                return true
            } else if throwScore.reduce(0,+) + score < 21 {
                throwScore.append(score)
                return true
            }
            return false
        } else if typeOfFrame == .spare {
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