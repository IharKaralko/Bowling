//
//  FrameProtocol.swift
//  Bowling
//
//  Created by Ihar_Karalko on 16.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation

protocol FrameProtocol {
    var isLast: Bool { get }
    var score: Int { get }
    var type: FrameType { get }
    
    var firstScore: Int?  { get }
    var secondScore: Int? { get }
    var thirdScore: Int?  { get }
    
    func bowl(with score: Int) -> Bool
    func appendBonus(_ score: Int)
    func isWaitForAddScore() -> Bool
    func isOpen() -> Bool
}

enum FrameType: Int {
    case standart
    case spare
    case strike
}
