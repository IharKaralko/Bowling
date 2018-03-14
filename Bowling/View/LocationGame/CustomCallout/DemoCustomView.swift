//
//  DemoCustomView.swift
//  Bowling
//
//  Created by Ihar_Karalko on 14.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit

class DemoCustomView: UIView {

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
    func nibSetup() {
//        Bundle.main.loadNibNamed("CustomCalloutView", owner: self, options: nil)
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(contentView)

        let cal = CustomCalloutView()
        cal.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cal)
        
        let leg = CalloutLegView()
        leg.translatesAutoresizingMaskIntoConstraints = false
        addSubview(leg)
        
        
        NSLayoutConstraint.activate([
            cal.topAnchor.constraint(equalTo: topAnchor),
            cal.rightAnchor.constraint(equalTo: rightAnchor),
            cal.bottomAnchor.constraint(equalTo: bottomAnchor),
            cal.leftAnchor.constraint(equalTo: leftAnchor),

            leg.topAnchor.constraint(equalTo: topAnchor),
             leg.bottomAnchor.constraint(equalTo: bottomAnchor),
             leg.rightAnchor.constraint(equalTo: rightAnchor),
              leg.leftAnchor.constraint(equalTo: leftAnchor)
            ])
    }
    
    func setupLayout() {
//        image.image = UIImage(named: "bow.jpeg")
//        placeLabel.text = "This is place of Game?"
//        
        frame = CGRect(x: 0, y: 0, width: 430, height: 230)
        layer.cornerRadius = 25
        clipsToBounds = true
    }}
