//
//  GameProtocol.swift
//  Bowling
//
//  Created by Ihar_Karalko on 16.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation

protocol GameProtocol {
    var maxFrameCount: Int { get }
    var score: Int { get }
    var isOpen: Bool{ get }
    
    func bowl(bowlScore: Int) -> Bool
}
