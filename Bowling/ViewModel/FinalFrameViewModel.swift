//
//  FinalFrameViewModel.swift
//  Bowling
//
//  Created by Ihar_Karalko on 06.02.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation

class FinalFrameViewModel {
    var frame: Frame? {
        didSet {
            delegate?.frameDidChanged(frame)
        }
    }
    weak var delegate: FinalFrameViewModelProtocol?
}

protocol FinalFrameViewModelProtocol: class {
    func frameDidChanged(_ frame: Frame?)
}
