//
//  FrameViewModel.swift
//  Bowling
//
//  Created by Ihar_Karalko on 02.02.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation

class FrameViewModel {
    var frame: Frame? {
        didSet {
            delegate?.frameDidChanged(frame)
        }
    }
    weak var delegate: FrameViewModelProtocol?
    
    var scoreGame: Int = 0 {
        didSet {
            delegate?.scoreGameDidChanged(scoreGame)
        }
    }
}

protocol FrameViewModelProtocol: class {
    func frameDidChanged(_ frame: Frame?)
    func scoreGameDidChanged(_ score: Int)
}





















//var first: Int?
//var second: Int?
//var third: Int?
//private var bowls: [Int] = []

//    func scoresOfFrame(_ score: Int) -> Bool {
//        if bowls.isEmpty {
//            bowls.append(score)
//            first = score
//            if score == 10 {
//                second = 10
//                bowls = []
//            }
//            return true
//        }
//        if bowls.first! + score == 10 {
//            second = 11
//            bowls = []
//            return true
//        }
//        if bowls.first! + score < 10 {
//            second = score
//            bowls = []
//            return true
//        } else {
//            return false
//        }
//    }
//
//    func scoresOfLastFrame(_ score: Int) -> Bool{
//        if bowls.isEmpty {
//            bowls.append(score)
//            first = score
//            return true
//        } else if bowls.count == 1 {
//            return  secondThrowFinalFrame(score: score)
//        } else if bowls.count == 2 {
//            return thirdThrowFinalFrame(score: score)
//        } else {
//            return false
//        }
//    }
//}

//private extension FrameViewModel {
//    func secondThrowFinalFrame(score: Int) -> Bool {
//        if bowls.first! == 10 {
//            second = score
//            bowls.append(score)
//            return true
//        } else {
//            if bowls.first! + score == 10 {
//                second = 11
//                bowls.append(score)
//                return true
//            }
//            if bowls.first! + score < 10 {
//                second = score
//                bowls.append(score)
//                return true
//            }
//            return false
//        }
//    }
//
//    func thirdThrowFinalFrame(score: Int) -> Bool {
//        if bowls.first! == 10 {
//            if bowls.reduce(0,+) == 20 {
//                third = score
//                bowls.append(score)
//                return true
//            } else if bowls.reduce(0,+) + score < 21 {
//                third = score
//                bowls.append(score)
//                return true
//            }
//            return false
//        } else if bowls.reduce(0,+) == 10 {
//            third = score
//            bowls.append(score)
//            return true
//        }
//        return false
//    }
//}

