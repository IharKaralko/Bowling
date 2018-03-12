//
//  LocationGameViewModelProtocol .swift
//  Bowling
//
//  Created by Ihar_Karalko on 07.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result
import ReactiveCocoa

protocol LocationGameViewModelOutputProtocol {
    var output: Signal<GameSessionViewModel.Action, NoError> { get }
}
