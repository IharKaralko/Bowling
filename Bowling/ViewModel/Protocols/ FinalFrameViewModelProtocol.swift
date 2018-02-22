//
//   FinalFrameViewModelProtocol.swift
//  Bowling
//
//  Created by Ihar_Karalko on 22.02.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation
import ReactiveCocoa
import ReactiveSwift
import Result

protocol FinalFrameOutputProtocol {
    var output: Signal<FinalFrameView.Action, NoError> { get }
}
