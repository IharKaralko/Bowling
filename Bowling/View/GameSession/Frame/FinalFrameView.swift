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
    
    var finalFrameViewModel: FinalFrameViewModel! {
        didSet {
            bindViewModel()
        }
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
}

extension FinalFrameView {
    func bindViewModel() {
        finalFrameViewModel.delegate = self
    }
    
    func fillFrom(frame: Frame?) {
        firstScore.text = (frame?.firstScore)! == 10 ? "x" : frame?.firstScore?.description
        if let secondBowl = frame?.secondScore {
            if (frame?.firstScore)! < 10 && (frame?.firstScore)! + secondBowl == 10 {
                secondScore.text = "/"
            }  else {
                secondScore.text = secondBowl == 10 ? "x": secondBowl.description
            }
        }  else {
            secondScore.text = frame?.secondScore?.description
        }
        if let thidBowl = frame?.thirdScore {
            thirdScore.text = thidBowl == 10 ? "x" : thidBowl.description
        } else {
            thirdScore.text = frame?.thirdScore?.description
        }
    }

    func fillNumberFrame(frameNumber: Int) {
        numberFrame.text = frameNumber.description
    }
  
    func  fillScoreGame(finalScore: Int) {
        totalScore.text = finalScore.description
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

extension FinalFrameView: FinalFrameViewModelProtocol {
    func frameDidChanged(_ frame: Frame?) {
        fillFrom(frame: frame)
    }
    func scoreGameDidChanged(_ score: Int) {
        fillScoreGame(finalScore: score)
    }
}
