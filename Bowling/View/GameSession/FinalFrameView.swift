//
//  FinalFrameView.swift
//  Bowling
//
//  Created by Ihar_Karalko on 31.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit

class FinalFrameView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var numberFrame: UILabel!
    @IBOutlet weak var totalScore: UILabel!
    @IBOutlet weak var firstScore: UILabel!
    @IBOutlet weak var secondScore: UILabel!
    @IBOutlet weak var thirdScore: UILabel!
    

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
}

extension FinalFrameView: FrameViewProtocol {
    
    func configureFinalFrame(frameNumber: Int, firstThrowScore: Int, secondThrowScore: Int, thirdThrowScore: Int, finalScore: Int) {
        numberFrame.text = frameNumber.description
        firstScore.text = firstThrowScore.description
        secondScore.text = secondThrowScore.description
        thirdScore.text = thirdThrowScore.description
        totalScore.text = finalScore.description
    }
    
    func fillNumberFrame(frameNumber: Int){
        numberFrame.text = frameNumber.description
    }
    
    func fillFirstScoreFinalFrame(firstThrowScore: Int){
        firstScore.text = firstThrowScore == 10 ? "x" : firstThrowScore.description
    }
    
    func fillSecondScoreFinalFrame(secondThrowScore: Int){
        if secondThrowScore == 11 {
            secondScore.text = "/"
        } else {
            secondScore.text = secondThrowScore == 10 ? "x" : secondThrowScore.description
        }
    }
    func fillThirdtScoreFinalFrame(thirdThrowScore: Int){
        thirdScore.text = thirdThrowScore.description
    }
}

private extension FinalFrameView {
    func setupLayout() {
        layer.borderWidth = 0.5
        numberFrame.layer.borderWidth = 0.5
        totalScore.layer.borderWidth = 0.5
        firstScore.layer.borderWidth = 0.5
        secondScore.layer.borderWidth = 0.5
        thirdScore.layer.borderWidth = 0.5
    }
    
    func nibSetup() {
        Bundle.main.loadNibNamed("FinalFrameView", owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: leftAnchor)
            ])
    }
}
