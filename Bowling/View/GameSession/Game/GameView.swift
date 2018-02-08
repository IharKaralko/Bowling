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
    var countFrame: Int { return viewModel.game.maxFrame }
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
    
    func activateButtonCollection(_ p: Int) {
        if p < 10 {
            for w in p ... 10 {
                buttonsCollection[w].isEnabled = false
                buttonsCollection[w].backgroundColor = UIColor.white
            }
        } else {
            for w in 0 ... 10 {
                buttonsCollection[w].isEnabled = true
                buttonsCollection[w].backgroundColor = UIColor.cyan
            }
        }
    }
}

// MARK: - Create Frames
private extension GameView {
    func commonInit(){
        var previousFrame: FrameView?
        var frames: [FrameView] = []
        
        contentFrame.subviews.forEach {
            $0.removeFromSuperview()
        }
        let count = countFrame < 6 ? countFrame: countFramesInRow + 1
        for i in 0 ..< count - 1 {
            let frameView = FrameView()
            let frameViewModel = viewModel.framesViewModel[i]
            frameView.frameViewModel = frameViewModel
            frameView.translatesAutoresizingMaskIntoConstraints = false
            contentFrame.addSubview(frameView)
            frameView.fillNumberFrame(frameNumber:  i + 1)
            if i == 0 {
                NSLayoutConstraint.activate([
                    frameView.topAnchor.constraint(equalTo:  contentFrame.topAnchor),
                    frameView.leftAnchor.constraint(equalTo: contentFrame.leftAnchor)
                    ])
                if count < countFramesInRow + 1 {
                    frameView.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor).isActive = true
                }
            } else {
                if let previousFrame = previousFrame {
                    NSLayoutConstraint.activate([
                        frameView.topAnchor.constraint(equalTo:  contentFrame.topAnchor),
                        frameView.leftAnchor.constraint(equalTo: previousFrame.rightAnchor, constant: 3),
                        frameView.widthAnchor.constraint(equalTo: previousFrame.widthAnchor),
                        frameView.heightAnchor.constraint(equalTo: previousFrame.heightAnchor)
                        ])
                }
                if i == countFramesInRow - 1 {
                    frameView.rightAnchor.constraint(equalTo: contentFrame.rightAnchor).isActive = true
                }
                
                if count < countFramesInRow + 1 {
                    frameView.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor).isActive = true
                }
            }
            previousFrame = frameView
            if count == countFramesInRow + 1 {
                frames.append(frameView)
            }
        }
        let rowsOfFrames = countFrame % countFramesInRow == 0 ? countFrame/countFramesInRow : Int(countFrame/countFramesInRow) + 1
        let framesInLastRow = countFrame > 5 ? countFrame - countFramesInRow*(rowsOfFrames - 1): 0
        if rowsOfFrames > 1 {
            for row in 2 ... rowsOfFrames{
                let countInRow = row < rowsOfFrames ? countFramesInRow :framesInLastRow - 1
                for i in 0 ..< countInRow {
                    let frameView = FrameView()
                    let frameViewModel = viewModel.framesViewModel[5*(row - 1) + i + 1]
                    frameView.frameViewModel = frameViewModel
                    frameView.translatesAutoresizingMaskIntoConstraints = false
                    contentFrame.addSubview(frameView)
                    frameView.fillNumberFrame(frameNumber: 5*(row - 1) + i + 1)
                    if i == 0 {
                        NSLayoutConstraint.activate([
                            frameView.topAnchor.constraint(equalTo:   frames[0].bottomAnchor, constant: 10),
                            frameView.leftAnchor.constraint(equalTo:  contentFrame.leftAnchor),
                            frameView.heightAnchor.constraint(equalTo: frames[0].heightAnchor)
                            ])
                        if countInRow < countFramesInRow {
                            frameView.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor).isActive = true
                        }
                        if countInRow == countFramesInRow {
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
                        if i == countFramesInRow - 1 {
                            frameView.rightAnchor.constraint(equalTo: contentFrame.rightAnchor).isActive = true
                        }
                        if countInRow < countFramesInRow {
                            frameView.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor).isActive = true
                        }
                        if countInRow == countFramesInRow {
                            frames[i] = frameView
                        }
                    }
                    previousFrame = frameView
                }
            }
        }
        let finalFrameView = FinalFrameView()
        let finalFrameViewModel = viewModel.finalFrameViewModel
        finalFrameView.finalFrameViewModel = finalFrameViewModel
        finalFrameView.translatesAutoresizingMaskIntoConstraints = false
        contentFrame.addSubview(finalFrameView)
        finalFrameView.fillNumberFrame(frameNumber: countFrame)
        NSLayoutConstraint.activate([
            finalFrameView.rightAnchor.constraint(equalTo: contentFrame.rightAnchor),
            finalFrameView.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor)
            ])
        if framesInLastRow > 0 {
            finalFrameView.topAnchor.constraint(equalTo:  frames[framesInLastRow-1].bottomAnchor, constant: 10).isActive = true
            finalFrameView.heightAnchor.constraint(equalTo:frames[framesInLastRow-1].heightAnchor).isActive = true
        }
        if framesInLastRow == 0 {
            finalFrameView.topAnchor.constraint(equalTo: contentFrame.topAnchor).isActive = true
        }
        if framesInLastRow > 1 || framesInLastRow == 0 {
            if let previousFrame = previousFrame {
                finalFrameView.leftAnchor.constraint(equalTo: previousFrame.rightAnchor, constant: 3).isActive = true
            }
        }
        if framesInLastRow == 1 {
            finalFrameView.leftAnchor.constraint(equalTo: contentFrame.leftAnchor).isActive = true
        }
        if framesInLastRow > 1 || framesInLastRow == 0 {
            if let previousFrame = previousFrame {
                finalFrameView.widthAnchor.constraint(equalTo: previousFrame.widthAnchor).isActive = true
            }
        }
    }
}

