//
//  GameView.swift
//  Bowling
//
//  Created by Ihar_Karalko on 30.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result
import ReactiveCocoa

class GameView: UIView {
    
    deinit {
        print("GameView deinit")
    }
    var viewModel: GameViewModelProtocol! {
        didSet {
            setupObservationOfViewModelOutput()
            commonInit()
        }
    }
    var countFrame: Int { return viewModel.currentGame.maxFrame }
    let countFramesInRow = 5
    
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var contentFrame: UIView!
    @IBOutlet private weak var namePlayer: UILabel!
    @IBOutlet private weak var scoreGame: UILabel!
    @IBOutlet private var buttonsCollection: [UIButton]!
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        guard let index =  buttonsCollection.index(of: sender) else { return }
        scoreGame.text = "Playing Game"
        viewModel.makeBowl(bowlScore: index)
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
    
    func setupObservationOfViewModelOutput(){
        viewModel.output.observeValues { [weak self] value in
            switch value {
            case .trowDidEnding(let score):
                self?.availableButtonsDidChange(score)
            }
        }
        viewModel.output.observeCompleted {[weak self] in
            self?.stateOfGameDidChage()
        }
    }
    
    func availableButtonsDidChange(_ score: Int) {
        if score < 10 {
            for w in score ... 10 {
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
    
    func stateOfGameDidChage() {
        scoreGame.text = "Player \(namePlayer.text ?? "Sasha") got \(viewModel.currentGame.scoreGame) "
    }
}

// MARK: - Create Frames
private extension GameView {
    func commonInit(){
        namePlayer.text = viewModel.nameOfPlayerCurrentGame
        var previousFrame: FrameView?
        var frames: [FrameView] = []
        contentFrame.subviews.forEach {
            $0.removeFromSuperview()
        }
        let count = countFrame < countFramesInRow + 1 ? countFrame: countFramesInRow + 1
        for index in 0 ..< count - 1 {
            let frameView = FrameView()
            let frameViewModel = viewModel.collectionFramesViewModel[index]
            frameView.frameViewModel = frameViewModel
            frameView.translatesAutoresizingMaskIntoConstraints = false
            contentFrame.addSubview(frameView)
            frameView.topAnchor.constraint(equalTo:  contentFrame.topAnchor).isActive = true
            if count < countFramesInRow + 1 {
                frameView.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor).isActive = true
            }
            if index == 0 {
                frameView.leftAnchor.constraint(equalTo: contentFrame.leftAnchor).isActive = true
            } else {
                if let previousFrame = previousFrame {
                    NSLayoutConstraint.activate([
                        frameView.leftAnchor.constraint(equalTo: previousFrame.rightAnchor, constant: 3),
                        frameView.widthAnchor.constraint(equalTo: previousFrame.widthAnchor),
                        frameView.heightAnchor.constraint(equalTo: previousFrame.heightAnchor)
                        ])
                }
                if index == countFramesInRow - 1 {
                    frameView.rightAnchor.constraint(equalTo: contentFrame.rightAnchor).isActive = true
                }
            }
            previousFrame = frameView
            if count == countFramesInRow + 1 {
                frames.append(frameView)
            }
        }
        let rowsOfFrames = countFrame % countFramesInRow == 0 ? countFrame/countFramesInRow : Int(countFrame/countFramesInRow) + 1
        let framesInLastRow = countFrame > countFramesInRow ? countFrame - countFramesInRow*(rowsOfFrames - 1): 0
        if rowsOfFrames > 1 {
            for row in 2 ... rowsOfFrames{
                let countInRow = row < rowsOfFrames ? countFramesInRow :framesInLastRow - 1
                for i in 0 ..< countInRow  {
                    let frameView = FrameView()
                    let frameViewModel = viewModel.collectionFramesViewModel[countFramesInRow * (row - 1) + i]
                    frameView.frameViewModel = frameViewModel
                    frameView.translatesAutoresizingMaskIntoConstraints = false
                    contentFrame.addSubview(frameView)
                    NSLayoutConstraint.activate([
                        frameView.topAnchor.constraint(equalTo:  frames[i].bottomAnchor, constant: 10),
                        frameView.heightAnchor.constraint(equalTo: frames[0].heightAnchor)
                        ])
                    if countInRow < countFramesInRow {
                        frameView.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor).isActive = true
                    } else {
                        frames[i] = frameView
                    }
                    if i == 0 {
                        frameView.leftAnchor.constraint(equalTo:  contentFrame.leftAnchor).isActive = true
                    } else {
                        if let previousFrame = previousFrame {
                            NSLayoutConstraint.activate([
                                frameView.leftAnchor.constraint(equalTo: previousFrame.rightAnchor, constant: 3),
                                frameView.widthAnchor.constraint(equalTo: previousFrame.widthAnchor)
                                ])
                        }
                        if i == countFramesInRow - 1 {
                            frameView.rightAnchor.constraint(equalTo: contentFrame.rightAnchor).isActive = true
                        }
                    }
                    previousFrame = frameView
                }
            }
        }
        let finalFrameView = FinalFrameView()
        let finalFrameViewModel = viewModel.currentFinalFrameViewModel
        finalFrameView.finalFrameViewModel = finalFrameViewModel
        finalFrameView.translatesAutoresizingMaskIntoConstraints = false
        contentFrame.addSubview(finalFrameView)
        NSLayoutConstraint.activate([
            finalFrameView.rightAnchor.constraint(equalTo: contentFrame.rightAnchor),
            finalFrameView.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor)
            ])
        if framesInLastRow > 0 {
            finalFrameView.topAnchor.constraint(equalTo:  frames[framesInLastRow - 1].bottomAnchor, constant: 10).isActive = true
            finalFrameView.heightAnchor.constraint(equalTo:frames[framesInLastRow - 1].heightAnchor).isActive = true
        } else {
            finalFrameView.topAnchor.constraint(equalTo: contentFrame.topAnchor).isActive = true
        }
        if framesInLastRow == 1 {
            finalFrameView.leftAnchor.constraint(equalTo: contentFrame.leftAnchor).isActive = true
        } else {
            if let previousFrame = previousFrame {
                finalFrameView.leftAnchor.constraint(equalTo: previousFrame.rightAnchor, constant: 3).isActive = true
                finalFrameView.widthAnchor.constraint(equalTo: previousFrame.widthAnchor).isActive = true
            }
        }
    }
}

extension GameView {
    enum Action {
        case trowDidEnding(score: Int)
    }
}
