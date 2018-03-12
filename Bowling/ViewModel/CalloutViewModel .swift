//
//  CalloutViewModel .swift
//  Bowling
//
//  Created by Ihar_Karalko on 12.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation
import MapKit
import ReactiveCocoa
import ReactiveSwift
import Result

class CalloutViewModel {
    
    private var _pipe = Signal<Void, NoError>.pipe()
    
    func beginGameButtonPress(){
    
    _pipe.input.sendCompleted()
        
    }
}
// MARK: - CalloutViewModelOutputProtocol
extension CalloutViewModel: CalloutViewModelOutputProtocol {
    var output: Signal<Void, NoError> { return _pipe.output }
}
extension CalloutViewModel: CalloutViewModelProtocol {
    func beginNewGame(){
         beginGameButtonPress()
        
    }
    
}
