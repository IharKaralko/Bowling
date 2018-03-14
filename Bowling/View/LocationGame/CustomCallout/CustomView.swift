//
//  CustomView.swift
//  Bowling
//
//  Created by Ihar_Karalko on 14.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit

class CustomView: UIView {
    
    var customCalloutView: CustomCalloutView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    func nibSetup() {
        customCalloutView = CustomCalloutView()
        customCalloutView.translatesAutoresizingMaskIntoConstraints = false
        frame = CGRect(x: 0, y: 0, width: 230, height: 180)
        addSubview(customCalloutView)
        let leg = CalloutLegView()
        leg.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height - leg.bounds.height/2)
         addSubview(leg)
        
        NSLayoutConstraint.activate([
            customCalloutView.topAnchor.constraint(equalTo: topAnchor),
            customCalloutView.rightAnchor.constraint(equalTo: rightAnchor),
            customCalloutView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -leg.bounds.height),
            customCalloutView.leftAnchor.constraint(equalTo: leftAnchor)
           ])
      }
}
