//
//  GameTests.swift
//  BowlingTests
//
//  Created by Ihar_Karalko on 27.02.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import XCTest
@testable import Bowling

class GameTests: XCTestCase {
    var game: Game!
    
    override func setUp() {
        super.setUp()
        game = Game(maxFrameCount: 5)
    }
    
    override func tearDown() {
        game = nil
        super.tearDown()
    }
    
    func testImpossibleGame(){
        game.bowl(bowlScore: -19)
        game.bowl(bowlScore: 7)
        game.bowl(bowlScore: 0)
        
        XCTAssertTrue(game.score == 7, "scoreGame \(game.score)")
    }
    
    func testImpossibleBlows(){
        game.bowl(bowlScore: 9)
        game.bowl(bowlScore: 7)
        game.bowl(bowlScore: 10)
        game.bowl(bowlScore: 10)
        game.bowl(bowlScore: 1)
        game.bowl(bowlScore: 0)
        
        XCTAssertTrue(game.score == 10, "scoreGame \(game.score)")
    }
    
    func testAdditionalScoreSpare() {
        game.bowl(bowlScore: 3)
        game.bowl(bowlScore: 7)
        game.bowl(bowlScore: 10)
        
        XCTAssertTrue(game.score == 20, "scoreGame \(game.score)")
    }
    
    func testAdditionalScoreStrike() {
        game.bowl(bowlScore: 10)    //26
        game.bowl(bowlScore: 10)    //26 + 19 = 45
        game.bowl(bowlScore: 6)
        game.bowl(bowlScore: 3)     //45 + 9 = 54
        
        XCTAssertTrue(game.score == 54, "scoreGame \(game.score)")
    }
    
    func testGameScoreAndGameIsOpen() {
        game.bowl(bowlScore: 6)
        game.bowl(bowlScore: 4)  // 16
        game.bowl(bowlScore: 6)
        game.bowl(bowlScore: 3)  //16 + 9 = 25
        game.bowl(bowlScore: 6)
        game.bowl(bowlScore: 6)   // impossible blow
        game.bowl(bowlScore: 1)   // 25 + 7 = 32
        
        XCTAssertTrue(game.score == 32, "scoreGame \(game.score)")
        
        game.bowl(bowlScore: 10)  // 32 + 10 + 10 = 52
        
        XCTAssertTrue(game.isOpen)
    
        game.bowl(bowlScore: 6)
        game.bowl(bowlScore: 4)
        game.bowl(bowlScore: 6)  // 52 + 16 = 68
        
                
        XCTAssertTrue(game.score == 68, "scoreGame \(game.score)")
        XCTAssertTrue(!game.isOpen)
    }
}
