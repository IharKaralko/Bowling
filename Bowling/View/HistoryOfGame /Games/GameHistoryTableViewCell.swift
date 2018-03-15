//
//  GameHistoryTableViewCell.swift
//  Bowling
//
//  Created by Ihar_Karalko on 13.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit

class GameHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var countOfPlayerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
extension GameHistoryTableViewCell {
    func configureCell(_ date: String, _ countOfPlayer: String) {
        dateLabel.text = date
        countOfPlayerLabel.text = countOfPlayer
    }
}
