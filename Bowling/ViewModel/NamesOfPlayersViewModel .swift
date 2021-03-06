//
//  NamesOfPlayersViewModel .swift
//  Bowling
//
//  Created by Ihar_Karalko on 24.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation
import ReactiveCocoa
import ReactiveSwift
import Result

class NamesOfPlayersViewModel {
    
    deinit {
        print("NamesOfPlayersViewModel deinit")
    }
    
    private var countOfPlayers: Int
    private var _pipe = Signal<NamesOfPlayersCoordinator.Action, NoError>.pipe()
    private var inputNamesOfPlayersAction: Action<[String], Void, NoError>!
    private var doneBackAction: Action<Void, Void, NoError>!
    
    init(countOfPlayers: Int) {
        self.countOfPlayers  = countOfPlayers
        
        self.doneBackAction = Action() { [weak self]  in
            return SignalProducer { observer, _ in
                self?._pipe.input.sendCompleted()
                observer.sendCompleted()
            }
        }
        
        self.inputNamesOfPlayersAction = Action() { [weak self] input in
            return SignalProducer { observer, _ in
                self?._pipe.input.send(value: .namesOfPlayersDidSelect(names: input))
                observer.sendCompleted()
            }
        }
    }
}

// MARK: - NamesOfPlayersProtocol
extension NamesOfPlayersViewModel: NamesOfPlayersProtocol {
    var numberOfPlayers: Int { return countOfPlayers }
    var namesOfPlayersAction: Action< [String], Void, NoError> { return inputNamesOfPlayersAction }
    var backCancelAction: Action< Void, Void, NoError>  { return doneBackAction }
}

// MARK: - NamesOfPlayersOutputProtocol
extension NamesOfPlayersViewModel: NamesOfPlayersOutputProtocol {
    var output: Signal<NamesOfPlayersCoordinator.Action, NoError> { return _pipe.output }
}
