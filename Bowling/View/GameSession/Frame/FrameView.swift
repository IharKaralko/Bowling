//
//  FrameView.swift
//  Bowling
//
//  Created by Ihar_Karalko on 30.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit

class FrameView: UIView {
    
    deinit {
        print("FrameView deinit")
    }
    
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var numberFrame: UILabel!
    @IBOutlet private weak var totalScore: UILabel!
    @IBOutlet private weak var firstScore: UILabel!
    @IBOutlet private weak var secondScore: UILabel!
    
    var frameViewModel: FrameViewModel! {
        willSet {
            //frameViewModel?.delegate = nil
        }
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

private extension FrameView {
    func bindViewModel() {
        numberFrame.text = frameViewModel.numberOfFrame.description
        frameViewModel.output.observeValues {[weak self] value in
            switch value {
            case .frameDidChanged(let frame):
                self?.frameDidChanged(frame)
            case .fillScoreGame(let score):
                self?.scoreGameDidChanged(score)
            }
        }
     // frameViewModel.delegate = self
    }
    
    func fillScoreGame(score: Int){
        totalScore.text = score.description
    }

    func fillFrom(frame: Frame?) {
        firstScore.text =  frame?.firstScore?.description
        if let secondBowl = frame?.secondScore {
            if (frame?.firstScore)! < 10 && (frame?.firstScore)! + secondBowl == 10 {
                secondScore.text = "/"
            } else {
                secondScore.text = secondBowl.description
            }
        }  else if (frame?.firstScore)! == 10 {
            secondScore.text = "x"
        } else {
            secondScore.text = frame?.secondScore?.description
        }
    }

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

extension FrameView { //}: FrameViewModelProtocol {
    func frameDidChanged(_ frame: Frame?) {
        fillFrom(frame: frame)
    }
    func scoreGameDidChanged(_ score: Int) {
        fillScoreGame(score: score)
    }
}

extension FrameView {
    enum Action {
        case frameDidChanged(frame: Frame?)
        case  fillScoreGame(score: Int)
    }
}


