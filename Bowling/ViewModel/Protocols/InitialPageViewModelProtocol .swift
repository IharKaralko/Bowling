//
//  InitialPageViewModelProtocol .swift
//  Bowling
//
//  Created by Ihar_Karalko on 07.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result
import ReactiveCocoa

protocol InitialPageViewModelProtocol {
    
    var beginNewGameAction: Action<Void, Void, NoError> { get }
    var goToHistoryAction: Action<Void, Void, NoError> { get }
    
}

protocol InitialPageViewModelOutputProtocol {
    var output: Signal<InitialPageCoordinator.Action, NoError> { get }
}
