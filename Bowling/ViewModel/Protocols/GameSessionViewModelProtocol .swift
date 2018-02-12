//
//  GameSessionViewModelProtocol .swift
//  Bowling
//
//  Created by Ihar_Karalko on 01.02.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation

protocol GameSessionViewModelProtocol{
    var coordinatorDelegate: GameSessionViewModelDelegate? { get set }
    var names: [String]{ get set }
    func doneBack()
   // let gamesModels: [GameViewModel]
    
}

protocol GameSessionViewModelDelegate: class {
    func gameSessionViewModelDoneBack()
    //func gameSessionFinish()
}
