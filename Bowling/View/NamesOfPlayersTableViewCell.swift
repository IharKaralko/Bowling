//
//  NamesOfPlayersTableViewCell.swift
//  Bowling
//
//  Created by Ihar_Karalko on 20.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit

//MARK: Protocol .
protocol NamesOfPlayersTableViewCellDelegate: class {
      // func saveTextField(_ cell: NamesOfPlayersTableViewCell?)
    func saveTextField(_ nuberString: String, _ namePlayer: String)
    
}


class NamesOfPlayersTableViewCell: UITableViewCell, UITextFieldDelegate{

    @IBOutlet weak var textFieldPlayer: UITextField!
    @IBOutlet weak var labelPlayer: UILabel!
    
     weak var delegate: NamesOfPlayersTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textFieldPlayer.delegate = self
    }

    func textField(_ textFieldToChange: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == " " {
            return false
        }
        let resultString = textFieldPlayer.text
        
        return (resultString?.count)! < 10
    }
    
    func textFieldIsFull() -> Bool {
        guard let text = textFieldPlayer.text, !text.isEmpty else {
            return false
        }
        return true
    }
    
    
     public func textFieldDidEndEditing(_ textField: UITextField){
      
        if textFieldIsFull(){
             self.textFieldPlayer.backgroundColor = UIColor.clear
            delegate?.saveTextField(self.labelPlayer.text!, self.textFieldPlayer.text!)
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
