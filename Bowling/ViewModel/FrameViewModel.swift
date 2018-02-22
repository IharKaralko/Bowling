//
//  FrameViewModel.swift
//  Bowling
//
//  Created by Ihar_Karalko on 02.02.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result
import ReactiveCocoa

class FrameViewModel {
    
     private var _pipe = Signal<FrameView.Action, NoError>.pipe()
    
    let numberOfFrame: Int
    deinit {
        print("FrameViewModel deinit")
    }
    init(numberOfFrame: Int){
        self.numberOfFrame = numberOfFrame
    }
  
    var frame: Frame? {
        didSet {
            guard let frame = frame else { return }
            _pipe.input.send(value: FrameView.Action.frameDidChanged(frame: frame))
            
          //  delegate?.frameDidChanged(frame)
        }
    }
  //  weak var delegate: FrameViewModelProtocol?
    
    var scoreGame: Int = 0 {
        didSet {
           _pipe.input.send(value: FrameView.Action.fillScoreGame(score: scoreGame))
            
            //delegate?.scoreGameDidChanged(scoreGame)
        }
    }
}
// MARK: - FrameOutputProtocol
extension  FrameViewModel:  FrameOutputProtocol {
    var output: Signal<FrameView.Action, NoError> { return _pipe.output }
}

//protocol FrameViewModelProtocol: class {
//    func frameDidChanged(_ frame: Frame?)
//    func scoreGameDidChanged(_ score: Int)
//}

