//
//  NamesOfPlayersTableViewCell.swift
//  Bowling
//
//  Created by Ihar_Karalko on 20.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit

class NamesOfPlayersTableViewCell: UITableViewCell, UITextFieldDelegate{

    @IBOutlet weak var textFieldPlayer: UITextField!
    @IBOutlet weak var labelPlayer: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textFieldPlayer.delegate = self
       // Initialization code
    }

//    func textField(_ textFieldToChange: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if string.isEmpty {
//            print("Empty")
//            return false
//        }
//        return true
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
