//
//  InitialPageViewModel.swift
//  Bowling
//
//  Created by Ihar_Karalko on 07.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

class InitialPageViewModel {
    
    private var _pipe = Signal<InitialPageCoordinator.Action, NoError>.pipe()
    private var startNewGameAction: Action<Void, Void, NoError>!
    private var showHistoryAction: Action<Void, Void, NoError>!
    
    init() {
        self.startNewGameAction = Action() { [weak self] input in
            return  SignalProducer<Void, NoError> { observer, _ in
                self?._pipe.input.send(value: InitialPageCoordinator.Action.startNewGame)
                observer.sendCompleted()
            }
        }
        self.showHistoryAction = Action() { [weak self] input in
            return  SignalProducer<Void, NoError> { observer, _ in
                self?._pipe.input.send(value: InitialPageCoordinator.Action.showHistory)
                observer.sendCompleted()
            }
        }
    }
}

// MARK: - InitialPageViewModelProtocol
extension InitialPageViewModel: InitialPageViewModelProtocol {

    var beginNewGameAction: Action<Void, Void, NoError> { return startNewGameAction }
    var goToHistoryAction: Action<Void, Void, NoError> {  return showHistoryAction }
    
}
    
   

// MARK: - InitialPageViewModeOutputProtocol
extension InitialPageViewModel: InitialPageViewModelOutputProtocol {
    var output: Signal<InitialPageCoordinator.Action, NoError> {
        return _pipe.output
    }
}

