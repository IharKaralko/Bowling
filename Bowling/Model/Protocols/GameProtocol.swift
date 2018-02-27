//
//  GameProtocol.swift
//  Bowling
//
//  Created by Ihar_Karalko on 16.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result
import ReactiveCocoa

protocol GameProtocol {
    var maxFrame: Int { get }
    var score: Int { get }
    var isOpen: Bool{ get }
    var indexCurrentFrame: Int { get }
    func bowl(bowlScore: Int) -> Bool
}



protocol GameOutputProtocol {
    var output: Signal<(), NoError> { get }
}
