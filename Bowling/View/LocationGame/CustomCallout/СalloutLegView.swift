//
//  DemoView.swift
//  Bowling
//
//  Created by Ihar_Karalko on 03.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit

class CalloutLegView: UIView {

    var path: UIBezierPath!
     override init(frame: CGRect){
        super.init(frame: frame)
       setupLayout()
        maskSublayer()
      }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
        maskSublayer()
     }
    
    override func draw(_ rect: CGRect) {
        self.createTriangle()
        UIColor.yellow.setFill()
        path.fill()
     }
 
    func maskSublayer(){
        self.createTriangle()
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.yellow.cgColor
         self.layer.mask = shapeLayer
    }
    
    func createTriangleOne() {
        path = UIBezierPath()
        path.move(to: CGPoint(x: self.frame.width/2, y: 0.0))
        path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))
        path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        path.close()
        
    }
    func createTriangle() {
        path = UIBezierPath()
        path.move(to: CGPoint(x: self.frame.width/2, y:   self.frame.size.height))
        path.addCurve(to:  CGPoint(x: 0.0, y: 0.0), controlPoint1: CGPoint(x:  self.frame.width/2 - 25, y: self.frame.size.height/2), controlPoint2:  CGPoint(x: 3.0, y: 3.0))
        path.addLine(to: CGPoint(x: self.frame.width, y:   0.0))
        path.addCurve(to: CGPoint(x: self.frame.width/2, y:   self.frame.size.height), controlPoint1: CGPoint(x:  self.frame.width - 3, y: 3), controlPoint2:  CGPoint(x:  self.frame.width/2 + 25, y: self.frame.size.height/2))
        
    }
    
    func setupLayout(){
        let width: CGFloat = 170.0
        let height: CGFloat = 50.0
        
        frame = CGRect(x: frame.size.width/2 - width/2,
                       y: frame.size.height/2 - height/2,
                       width: width,
                       height: height)
    }
}
