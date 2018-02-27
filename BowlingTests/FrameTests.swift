//
//  FrameTests.swift
//  BowlingTests
//
//  Created by Ihar_Karalko on 27.02.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import XCTest
@testable import Bowling

class FrameTests: XCTestCase {
    var frame: Frame!
    
    override func setUp() {
        super.setUp()
        frame = Frame(isLastFrame: false)
    }
    
    override func tearDown() {
        frame = nil
        super.tearDown()
    }
    
    func testFrameTypeStrike(){
        frame.bowl(with: 10)
        
        XCTAssertTrue(frame.type == .strike)
    }
    
    func testFrameTypeSpare(){
        frame.bowl(with: 4)
        frame.bowl(with: 6)
        
        XCTAssertTrue(frame.type == .spare)
    }
    
    func testFrameTypeStandart(){
        frame.bowl(with: 1)
        frame.bowl(with: 6)
        
        XCTAssertTrue(frame.type == .standart)
    }
    
    func testFrameScore(){
        frame.bowl(with: 6)
        frame.bowl(with: 6)        // impossible blow
        
        XCTAssertTrue(frame.score == 6)
    }
 
}
