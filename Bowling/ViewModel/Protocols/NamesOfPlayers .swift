//
//  NamesOfPlayers .swift
//  Bowling
//
//  Created by Ihar_Karalko on 24.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation

protocol NamesOfPlayersViewModelDelegate: class {
    func namesOfPlayersViewModelDidSelect(_ collectionOfNames: [String])
    func namesOfPlayersViewModelDoneBack()
}

protocol NamesOfPlayers {
    var countOfPlayers: Int { get set }
    var collectionOfNames: [String] { get set }
    var coordinatorDelegate: NamesOfPlayersViewModelDelegate? { get set}
    func acceptNamesOfPlayers(collectionOfNames: [String])
    func doneBack()
}
