//
//  Player .swift
//  Bowling
//
//  Created by Ihar_Karalko on 06.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation

struct Player {
    let id: String
    let name: String
    var scoreGame: Int
    
    init(id: String, name: String,  scoreGame: Int){
        self.id = id
        self.name = name
        self.scoreGame = scoreGame
    }
}
