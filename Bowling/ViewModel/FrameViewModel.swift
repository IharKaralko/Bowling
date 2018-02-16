//
//  FrameViewModel.swift
//  Bowling
//
//  Created by Ihar_Karalko on 02.02.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation

class FrameViewModel {
    
    let numberOfFrame: Int
    deinit {
        print("FrameViewModel deinit")
    }
    init(numberOfFrame: Int){
        self.numberOfFrame = numberOfFrame
    }
  
    var frame: Frame? {
        didSet {
            delegate?.frameDidChanged(frame)
        }
    }
    weak var delegate: FrameViewModelProtocol?
    
    var scoreGame: Int = 0 {
        didSet {
            delegate?.scoreGameDidChanged(scoreGame)
        }
    }
}

protocol FrameViewModelProtocol: class {
    func frameDidChanged(_ frame: Frame?)
    func scoreGameDidChanged(_ score: Int)
}
