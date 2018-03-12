//
//  CountOfPlayerViewModel.swift
//  Bowling
//
//  Created by Ihar_Karalko on 17.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

class CountOfPlayerViewModel {
    
    private var _pipe = Signal<CountOfPlayerCoordinator.Action, NoError>.pipe()
    private var inputNumber: Int = 10
    private var inputNumbersOfPlayersAction: Action<Int, Void, NoError>!
    private var doneBackAction: Action<Void, Void, NoError>!
    
    
    init() {
        self.inputNumbersOfPlayersAction = Action() { [weak self] input in
            return  SignalProducer<Void, NoError> { observer, _ in
                self?._pipe.input.send(value: CountOfPlayerCoordinator.Action.inputCountOfPlayers(count: input))
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

// MARK: - CountOfPlayerProtocol
extension CountOfPlayerViewModel: CountOfPlayerProtocol {
    var numberOfPlayers:  Int {
        return inputNumber
    }
    var getNumbersOfPlayersAction: Action<Int, Void, NoError> {
        return inputNumbersOfPlayersAction
    }
    var backCancelAction: Action< Void, Void, NoError>  { return doneBackAction }
    
}

// MARK: - CountOfPlayerOutputProtocol
extension CountOfPlayerViewModel: CountOfPlayerOutputProtocol {
    var output: Signal<CountOfPlayerCoordinator.Action, NoError> {
        return _pipe.output
    }
}
