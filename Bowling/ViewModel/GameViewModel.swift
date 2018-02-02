//
//  GameViewModel.swift
//  Bowling
//
//  Created by Ihar_Karalko on 01.02.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation

class GameViewModel{
    
    var game: Game = Game()
    
    func makeRoll(bowlScore: Int){
        
        game.makeBowl(bowlScore: bowlScore)
        
    }
}
