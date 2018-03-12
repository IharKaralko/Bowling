//
//  CalloutViewModelProtocol .swift
//  Bowling
//
//  Created by Ihar_Karalko on 12.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result
import ReactiveCocoa

protocol CalloutViewModelOutputProtocol {
    var output: Signal<Void, NoError> { get }
}

protocol CalloutViewModelProtocol {
     func beginNewGame()
    
}
