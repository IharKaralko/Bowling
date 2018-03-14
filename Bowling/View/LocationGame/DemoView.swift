//
//  DemoView.swift
//  Bowling
//
//  Created by Ihar_Karalko on 14.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit

class DemoView: UIView {

   
        var path: UIBezierPath!
        override init(frame: CGRect){
            super.init(frame: frame)
            nibSetup()
            setupLayout()
    
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            nibSetup()
            setupLayout()
    
        }
    func nibSetup(){
        let cal = CustomCalloutView()
        let leg = CalloutLegView()
        addSubview(cal)
        addSubview(leg)
        
    }
        
        func setupLayout(){
            let width: CGFloat = 240.0
            let height: CGFloat = 160.0
            
            frame = CGRect(x: frame.size.width/2 - width/2,
                           y: frame.size.height/2 - height/2,
                           width: width,
                           height: height)
        }
    }

