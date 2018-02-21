//
//  GameSessionViewModelProtocol .swift
//  Bowling
//
//  Created by Ihar_Karalko on 01.02.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation
import ReactiveCocoa
import ReactiveSwift
import Result

protocol GameSessionViewModelProtocol {
  //  var coordinatorDelegate: GameSessionViewModelDelegate? { get set }
    var namesOfPlayer: [String]{ get set }
    func doneBack()
 
    
}

//protocol GameSessionViewModelDelegate: class {
//    func gameSessionViewModelDoneBack()
// }

protocol GameSessionOutputProtocol {
    var output: Signal<Void, NoError> { get }
}
