//
//  FinalFrameView.swift
//  Bowling
//
//  Created by Ihar_Karalko on 31.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result
import ReactiveCocoa

class FinalFrameView: UIView {
    
    deinit {
        print("\(type(of: self)).\(#function)")
    }
    
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var numberFrame: UILabel!
    @IBOutlet private weak var totalScore: UILabel!
    @IBOutlet private weak var firstScore: UILabel!
    @IBOutlet private weak var secondScore: UILabel!
    @IBOutlet private weak var thirdScore: UILabel!
    
    private let bag =  CompositeDisposable()
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

private extension FinalFrameView {
    func bindViewModel() {
        numberFrame.text = finalFrameViewModel.numberLastFrame.description
         bag += finalFrameViewModel.output.observeValues {[weak self] value in
            switch value {
            case .frameDidChanged(let frame):
                self?.fillFrom(frame: frame)
            case .fillScoreGame(let finalScore):
                self?.fillScoreGame(finalScore: finalScore)
            }
        }
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
 
    func  fillScoreGame(finalScore: Int) {
        totalScore.text = finalScore.description
    }
    
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

extension FinalFrameView {
    enum Action {
        case frameDidChanged(frame: Frame?)
        case  fillScoreGame(finalScore: Int)
    }
}
