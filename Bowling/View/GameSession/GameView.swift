//
//  GameView.swift
//  Bowling
//
//  Created by Ihar_Karalko on 30.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit

class GameView: UIView {
    
    var viewModel: GameViewModel! {
        didSet {
            oldValue?.delegate = nil
            viewModel.delegate = self
            commonInit()
        }
    }
    var frames: [FrameView] = []
    var countFrame: Int { return viewModel.game.maxFrame }
    var previousFrame: FrameView?
    var d: Int = 0
    
    let countFramesInRow = 5
    
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var contentFrame: UIView!
    @IBOutlet private weak var namePlayer: UILabel!
    @IBOutlet private weak var scoreGame: UILabel!
    @IBOutlet private var buttonsCollection: [UIButton]!
    
    @IBAction func tappedButton(_ sender: UIButton) {
        guard let index =  buttonsCollection.index(of: sender) else { return }
        viewModel.makeRoll(bowlScore: index)
    }
    
    func activateButtonCollection(_ p: Int){
        if p < 10 {
            for w in p ... 10 {
                buttonsCollection[w].isEnabled = false
                buttonsCollection[w].backgroundColor = UIColor.white
            }
        }
        else {
            for w in 0 ... 10 {
                buttonsCollection[w].isEnabled = true
                buttonsCollection[w].backgroundColor = UIColor.cyan
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
}

extension GameView: GameViewModelProtocol {
    func availableScoreDidChange(_ score: Int) {
        activateButtonCollection(score)
    }
}

private extension GameView {
    func nibSetup() {
        Bundle.main.loadNibNamed("GameView", owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: leftAnchor)
            ])
    }
    
    func commonInit() {
        contentFrame.subviews.forEach {
            $0.removeFromSuperview()
        }
        let rowsOfFrames = countFrame % countFramesInRow == 0 ? countFrame/countFramesInRow : Int(countFrame/countFramesInRow) + 1
        if rowsOfFrames == 1 {
            firstRow(countFrame)
            finalFrame(0)
        } else {
            for m in 1 ... rowsOfFrames {
                if m == 1 {
                    firstRow(countFramesInRow + 1)
                } else if m < rowsOfFrames {
                    mediumRowsFrames(m - 1, countFramesInRow)
                } else {
                    let framesInLastRow = countFrame - countFramesInRow*(rowsOfFrames - 1)
                    if framesInLastRow > 1 {
                        mediumRowsFrames(m - 1, framesInLastRow - 1)
                    }
                    finalFrame(framesInLastRow)
                }
            }
        }
    }
}

// MARK: - Create Frames
private extension GameView {
    func firstRow(_ count: Int) {
        for i in 0 ..< count - 1 {
            
            let frameView = FrameView()
            let frameViewModel = viewModel.framesViewModel[d]
            d += 1
            frameView.frameViewModel = frameViewModel
            
            frameView.translatesAutoresizingMaskIntoConstraints = false
            contentFrame.addSubview(frameView)
            frameView.fillNumberFrame(frameNumber:  i + 1)
            if i == 0 {
                NSLayoutConstraint.activate([
                    frameView.topAnchor.constraint(equalTo:  contentFrame.topAnchor),
                    frameView.leftAnchor.constraint(equalTo: contentFrame.leftAnchor)
                    ])
                frameView.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor).isActive = count < countFramesInRow + 1  ? true : false
            }  else {
                if let previousFrame = previousFrame {
                NSLayoutConstraint.activate([
                    frameView.topAnchor.constraint(equalTo:  contentFrame.topAnchor),
                    frameView.leftAnchor.constraint(equalTo: previousFrame.rightAnchor, constant: 3),
                    frameView.widthAnchor.constraint(equalTo: previousFrame.widthAnchor),
                    frameView.heightAnchor.constraint(equalTo: previousFrame.heightAnchor)
                    ])
                }
                frameView.rightAnchor.constraint(equalTo: contentFrame.rightAnchor).isActive = i == 4 ? true : false
                frameView.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor).isActive = count < countFramesInRow + 1 ? true : false
            }
            previousFrame = frameView
            if count == countFramesInRow + 1 {
                frames.append(frameView)
            }
        }
    }
  
    func mediumRowsFrames(_ m: Int, _ s: Int) {
        for i in 0 ..< s {
            
            let frameView = FrameView()
            let frameViewModel = viewModel.framesViewModel[d]
             d += 1
            frameView.frameViewModel = frameViewModel
            
            frameView.translatesAutoresizingMaskIntoConstraints = false
            contentFrame.addSubview(frameView)
            frameView.fillNumberFrame(frameNumber: 5*m + i + 1)
            if i == 0 {
                NSLayoutConstraint.activate([
                    frameView.topAnchor.constraint(equalTo:   frames[0].bottomAnchor, constant: 10),
                    frameView.leftAnchor.constraint(equalTo:  contentFrame.leftAnchor),
                    frameView.heightAnchor.constraint(equalTo: frames[0].heightAnchor)
                    ])
                frameView.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor).isActive = s < countFramesInRow ? true : false
                if s == countFramesInRow {
                    frames[0] = frameView
                }
            } else {
                if let previousFrame = previousFrame {
                NSLayoutConstraint.activate([
                    frameView.topAnchor.constraint(equalTo:  frames[i].bottomAnchor, constant: 10),
                    frameView.heightAnchor.constraint(equalTo:frames[i].heightAnchor),
                    frameView.leftAnchor.constraint(equalTo: previousFrame.rightAnchor, constant: 3),
                    frameView.widthAnchor.constraint(equalTo: previousFrame.widthAnchor)
                    ])
                }
                frameView.rightAnchor.constraint(equalTo: contentFrame.rightAnchor).isActive = i == countFramesInRow - 1 ? true : false
                frameView.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor).isActive = s < countFramesInRow ? true : false
                if s == countFramesInRow {
                    frames[i] = frameView
                }
            }
            previousFrame = frameView
        }
    }
    
    func finalFrame(_ g: Int) {
        let finalFrame = FinalFrameView()
        finalFrame.finalFrameViewModel = FinalFrameViewModel()
         viewModel.finalFrameViewModel = finalFrame.finalFrameViewModel
        // gameFinalFrame = finalFrame
        finalFrame.translatesAutoresizingMaskIntoConstraints = false
        contentFrame.addSubview(finalFrame)
        finalFrame.fillNumberFrame(frameNumber: countFrame)
        NSLayoutConstraint.activate([
            finalFrame.rightAnchor.constraint(equalTo: contentFrame.rightAnchor),
            finalFrame.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor)
            ])
        if g > 0 {
            finalFrame.topAnchor.constraint(equalTo:  frames[g-1].bottomAnchor, constant: 10).isActive = true
            finalFrame.heightAnchor.constraint(equalTo:frames[g-1].heightAnchor).isActive = true
        }
        if let previousFrame = previousFrame {
            finalFrame.topAnchor.constraint(equalTo:  contentFrame.topAnchor).isActive = g == 0 ? true : false
        finalFrame.leftAnchor.constraint(equalTo: previousFrame.rightAnchor, constant: 3).isActive = g > 1 || g == 0 ? true : false
        finalFrame.leftAnchor.constraint(equalTo: contentFrame.leftAnchor).isActive = g == 1 ? true : false
        finalFrame.widthAnchor.constraint(equalTo: previousFrame.widthAnchor).isActive = g > 1 || g == 0 ? true : false
    }
    }
}

