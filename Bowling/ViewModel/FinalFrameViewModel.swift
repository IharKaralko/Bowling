//
//  FinalFrameViewModel.swift
//  Bowling
//
//  Created by Ihar_Karalko on 06.02.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result
import ReactiveCocoa

class FinalFrameViewModel {
    
    deinit {
        print("FinalFrameViewModel deinit")
    }
    
    let numberLastFrame: Int
    private var _pipe = Signal<FinalFrameView.Action, NoError>.pipe()
    
    var frame: Frame? {
        didSet {
              _pipe.input.send(value: FinalFrameView.Action.frameDidChanged(frame: frame))
        }
    }
    var scoreGame: Int = 0 {
        didSet {
             _pipe.input.send(value: FinalFrameView.Action.fillScoreGame(finalScore: scoreGame))
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

// MARK: - FinalFrameOutputProtocol
extension  FinalFrameViewModel:  FinalFrameOutputProtocol {
     var output: Signal<FinalFrameView.Action, NoError> { return _pipe.output }
}
