//
//  LocationGameViewModel.swift
//  Bowling
//
//  Created by Ihar_Karalko on 02.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation
import MapKit
import ReactiveCocoa
import ReactiveSwift
import Result

class LocationGameViewModel {
    
    deinit {
        print("\(type(of: self)).\(#function)")
    }
    
    private var _pipe = Signal<LocationGameCoordinator.Action, NoError>.pipe()
    private var doneBackAction: Action<Void, Void, NoError>!
    private var selectLocationAction: Action<ConfigurationGame, Void, NoError>!
    
    init() {
        self.selectLocationAction = Action() { [weak self]  input in
            return SignalProducer { observer, _ in
                self?._pipe.input.send(value: .selectLocationOfGame(configurationGame: input))
                //self?._pipe.input.sendCompleted()
                observer.sendCompleted()
            }
        }
        
        self.doneBackAction = Action() { [weak self]  in
            return SignalProducer { observer, _ in
                self?._pipe.input.sendCompleted()
                observer.sendCompleted()
            }
        }
    }
}

extension LocationGameViewModel: LocationGameViewModelProtocol {
    var beginGameAction:  Action< ConfigurationGame, Void, NoError> { return selectLocationAction}
    var backCancelAction: Action< Void, Void, NoError>  { return doneBackAction }
}

// MARK: - LocationGameViewModelOutputProtocol
extension LocationGameViewModel: LocationGameViewModelOutputProtocol {
    var output: Signal<LocationGameCoordinator.Action, NoError> { return _pipe.output }
}
