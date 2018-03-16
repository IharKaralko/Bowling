//
//  GameHistory .swift
//  Bowling
//
//  Created by Ihar_Karalko on 06.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation

struct GameHistory {
    
    let id: String
    let date: String
    let countOfPlayers: Int
    
    init(id: String, date: String, countOfPlayers: Int){
        self.id = id
        self.date = date
        self.countOfPlayers = countOfPlayers
    }
}
