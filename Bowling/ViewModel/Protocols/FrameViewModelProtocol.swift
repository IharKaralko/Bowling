//
//  FrameViewModelProtocol.swift
//  Bowling
//
//  Created by Ihar_Karalko on 22.02.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation
import ReactiveCocoa
import ReactiveSwift
import Result

protocol FrameOutputProtocol {
    var output: Signal<FrameView.Action, NoError> { get }
}
