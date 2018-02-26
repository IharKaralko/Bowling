//
//  NamesOfPlayersTableViewCell.swift
//  Bowling
//
//  Created by Ihar_Karalko on 20.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result
import ReactiveCocoa

class NamesOfPlayersTableViewCell: UITableViewCell {
    @IBOutlet private weak var textFieldPlayer: UITextField!
    @IBOutlet private weak var labelPlayer: UILabel!
    
   var output: Signal<NamesOfPlayersViewController.Action, NoError> { return _pipe.output }
   private var _pipe = Signal<NamesOfPlayersViewController.Action, NoError>.pipe()
 
     override func awakeFromNib() {
        super.awakeFromNib()
        textFieldPlayer.delegate = self
    }
}
    
extension NamesOfPlayersTableViewCell {
    func textFieldIsFull() -> Bool {
        guard let text = textFieldPlayer.text, !text.isEmpty  else {
            textFieldPlayer.backgroundColor = UIColor.red
            return false
        }
        textFieldPlayer.backgroundColor = UIColor.white
        return true
    }
    
    func returnTextOfCell()-> String? {
        return  textFieldPlayer.text
    }
    
    func configureCell(_ name: String?, _ number: String){
        textFieldPlayer.text = name
        labelPlayer.text = number
        
        if textFieldIsFull(){
            textFieldPlayer.backgroundColor = UIColor.white
            
        } else {
            textFieldPlayer.backgroundColor = UIColor.red
        }
    }
}

//MARK: - UITextFieldDelegate
extension NamesOfPlayersTableViewCell: UITextFieldDelegate {
    func textField(_ textFieldToChange: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        textFieldPlayer.backgroundColor = UIColor.white
        if string == " " { return false }
        let resultString = textFieldPlayer.text
        return (resultString?.count)! < 10
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        _pipe.input.send(value: NamesOfPlayersViewController.Action.cellDidEndEditing(cell: self))
    }
}
