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
    var numbersOfPlayer: Int
    
    var output: Signal<ModelAction, NoError>{ return _pipe.output }
    var correctNumber: Bool!
    private var _pipe = Signal<ModelAction, NoError>.pipe()
    var inputText = MutableProperty<String?>("10")
    var inputNumbersOfPlayers: Action<String?, Void, NoError>!
    
    weak var coordinatorDelegate: CountOfPlayerViewModelDelegate?
   
    init(numbersOfPlayer: Int = 10) {
       
        self.numbersOfPlayer = numbersOfPlayer
        
        self.inputNumbersOfPlayers = Action(enabledIf: isTextPresents(inputText)) {[weak self] input in
            if let  stringInt  = Int(input!), stringInt > 1 {
                //if stringInt > 0 {
                self?.correctNumber = true
                let signalProducer = SignalProducer<Void, NoError>{ observer, _ in
                     self?._pipe.input.send(value: ModelAction.someAction(someParam: stringInt))
                    //  self?.correctNumber = true
                    self?.inputText.value = ""
                    observer.sendCompleted()
                }
                return signalProducer
           // }
            } else {
                self?.correctNumber = false
                let signalProducer = SignalProducer<Void, NoError>{ observer, _ in
                    //self?._pipe.input.send(value: ModelAction.someAction(someParam: 8))
                    // self?.correctNumber = false
                    self?.inputText.value = input
                    observer.sendCompleted()
                }
                return signalProducer
            }
        }
    }
}
    
private extension CountOfPlayerViewModel {
    func isTextPresents(_ text: MutableProperty<String?>) -> Property<Bool> {
        return  text
            .map { $0?.isEmpty ?? true }
            .negate()
    }
}


// MARK: - CountOfPlayer protocol
extension CountOfPlayerViewModel: CountOfPlayer {
    func acceptCountOfPlayers(count: Int) {
        numbersOfPlayer = count
        coordinatorDelegate?.countOfPlayerViewModelDidSelect(numbersOfPlayer)
    }
}


