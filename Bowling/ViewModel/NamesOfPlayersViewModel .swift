//
//  NamesOfPlayersViewModel .swift
//  Bowling
//
//  Created by Ihar_Karalko on 24.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation

class NamesOfPlayersViewModel {
    var countOfPlayers: Int
    var collectionOfNames = [String]()
    weak var coordinatorDelegate: NamesOfPlayersViewModelDelegate?
    init (countOfPlayers: Int){
        self.countOfPlayers  = countOfPlayers
    }
}

// MARK: - CountOfPlayer protocol
extension NamesOfPlayersViewModel: NamesOfPlayers {
    func acceptNamesOfPlayers(collectionOfNames: [String]) {
        self.collectionOfNames = collectionOfNames
        coordinatorDelegate?.namesOfPlayersViewModelDidSelect(collectionOfNames)
    }
    
    func doneBack() {
        coordinatorDelegate?.namesOfPlayersViewModelDoneBack()
    }
}
