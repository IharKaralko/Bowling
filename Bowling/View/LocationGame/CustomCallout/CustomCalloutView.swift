//
//  CustomCalloutView.swift
//  Bowling
//
//  Created by Ihar_Karalko on 01.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit

class CustomCalloutView: UIView {
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var image: UIImageView!
    @IBOutlet private weak var placeLabel: UILabel!
    @IBOutlet private weak var adressLabel: UILabel!
 
    @IBAction func beginGameAction(_ sender: UIButton) {
    print("Begin")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         nibSetup()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
       setupLayout()
    }

    func fillAdress(_ adress: String?){
        adressLabel.text = adress
    }
    

    func nibSetup() {
        Bundle.main.loadNibNamed("CustomCalloutView", owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
   
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: leftAnchor)
            ])
    }
   
    func setupLayout() {
             image.image = UIImage(named: "bow.jpeg")
             placeLabel.text = "This is place of Game?"
        
        frame = CGRect(x: 0, y: 0, width: 230, height: 130)
        layer.cornerRadius = 25
        clipsToBounds = true
        
    }
}
