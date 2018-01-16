//
//  GameProtocol.swift
//  Bowling
//
//  Created by Ihar_Karalko on 16.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation

protocol GameProtocol {
    var maxFrame: Int { get }
    var scoreGame: Int { get }
    var isOpenGame: Bool{ get }
    
    func gameThrow(bowlScore: Int) -> Bool
}
