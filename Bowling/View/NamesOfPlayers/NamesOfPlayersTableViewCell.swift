//
//  NamesOfPlayersTableViewCell.swift
//  Bowling
//
//  Created by Ihar_Karalko on 20.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit

//MARK: - NamesOfPlayersTableViewCellDelegate
protocol NamesOfPlayersTableViewCellDelegate: class {
    func saveTextField(_ cell: NamesOfPlayersTableViewCell)
}

class NamesOfPlayersTableViewCell: UITableViewCell {
    @IBOutlet  private weak var textFieldPlayer: UITextField!
    @IBOutlet  private weak var labelPlayer: UILabel!
    
    weak var delegate: NamesOfPlayersTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textFieldPlayer.delegate = self
    }
}
    
extension NamesOfPlayersTableViewCell {
    func textFieldIsFull() -> Bool {
        guard let text = textFieldPlayer.text, !text.isEmpty  else {
            textFieldPlayer.backgroundColor = UIColor.cyan
            return false
        }
        textFieldPlayer.backgroundColor = UIColor.white
        return true
    }
    
    func textCell() -> String {
        return textFieldPlayer.text!
    }
    
    func numberOfPlayer(numberString: String){
        labelPlayer.text = numberString
    }
}

//MARK: - UITextFieldDelegate
extension NamesOfPlayersTableViewCell: UITextFieldDelegate {
    func textField(_ textFieldToChange: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == " " {
            return false
        }
        let resultString = textFieldPlayer.text
        return (resultString?.count)! < 10
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField){
        delegate?.saveTextField(self)
    }
}
