//
//  PlayerProtocol.swift
//  Bowling
//
//  Created by Ihar_Karalko on 18.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation

protocol PlayerProtocol {
    var name: String { get }
    var game: Game { get set }
}
