//
//  FinalFrameViewModel.swift
//  Bowling
//
//  Created by Ihar_Karalko on 06.02.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation

class FinalFrameViewModel {
    
    deinit {
        print("FinalFrameViewModel deinit")
    }
    
    let numberLastFrame: Int
    var frame: Frame? {
        didSet {
            delegate?.frameDidChanged(frame)
        }
    }
    weak var delegate: FinalFrameViewModelProtocol?
    var scoreGame: Int = 0 {
        didSet {
            delegate?.scoreGameDidChanged(scoreGame)
        }
    }
    
    init(numberLastFrame: Int) {
        self.numberLastFrame = numberLastFrame
    }
}

protocol FinalFrameViewModelProtocol: class {
    func frameDidChanged(_ frame: Frame?)
    func scoreGameDidChanged(_ score: Int)
}
