//
//  FrameView.swift
//  Bowling
//
//  Created by Ihar_Karalko on 30.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit

class FrameView: UIView {
    
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var numberFrame: UILabel!
    @IBOutlet private weak var totalScore: UILabel!
    @IBOutlet private weak var firstScore: UILabel!
    @IBOutlet private weak var secondScore: UILabel!

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

extension FrameView: FrameViewProtocol {
    func configureFrame(frameNumber: Int, firstThrowScore: Int, secondThrowScore: Int, finalScore: Int) {
        numberFrame.text = frameNumber.description
        firstScore.text = firstThrowScore.description
        secondScore.text = secondThrowScore.description
        totalScore.text = finalScore.description
    }
    
    func fillNumberFrame(frameNumber: Int){
        numberFrame.text = frameNumber.description
    }
    func fillFirstScoreFrame(firstThrowScore: Int){
        firstScore.text = firstThrowScore.description
    }
    func fillSecondScoreFrame(secondThrowScore: Int){
        if secondThrowScore == 11 {
            secondScore.text = "/"
        } else {
            secondScore.text = secondThrowScore == 10 ? "x" : secondThrowScore.description
        }
    }
}

private extension FrameView {
    func setupLayout() {
        layer.borderWidth = 0.5
        numberFrame.layer.borderWidth = 0.5
        totalScore.layer.borderWidth = 0.5
        firstScore.layer.borderWidth = 0.5
        secondScore.layer.borderWidth = 0.5
    }
    
    func nibSetup() {
        Bundle.main.loadNibNamed("FrameView", owner: self, options: nil)
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
