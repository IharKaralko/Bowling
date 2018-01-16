//
//  FrameProtocol.swift
//  Bowling
//
//  Created by Ihar_Karalko on 16.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation

protocol FrameProtocol {
    
    var isLast: Bool {get set}
    var scoreFrame: Int { get }
    var typeOfFrame: FrameType { get }
    
    func frameThrow(with score: Int) -> Bool
    
    func frameAppendAdditionalScore(_ score: Int)
    
    func frameIsWaiteForAddScore()-> Bool
    
    func frameIsOpen() -> Bool
}
