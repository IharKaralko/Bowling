//
//  GameView.swift
//  Bowling
//
//  Created by Ihar_Karalko on 30.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit

class GameView: UIView {
   
    @IBAction func tappedButton(_ sender: UIButton) {
        let index =  buttonsCollection.index(of: sender)
        if let indexx = index{
            let r = Int(indexx)
            print(r)
        }
    }
    
    let countFrame = 12
    var previousFrame = FrameView()
    var frames: [FrameView] = []
    let countFramesInRow = 5
    
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var contentFrame: UIView!
    @IBOutlet private weak var namePlayer: UILabel!
    @IBOutlet private weak var scoreGame: UILabel!
    @IBOutlet private var buttonsCollection: [UIButton]!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
        commonInit()
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
            let frame = FrameView()
            frame.translatesAutoresizingMaskIntoConstraints = false
            contentFrame.addSubview(frame)
            fillNumber(frame, i)
            
            if i == 0 {
                NSLayoutConstraint.activate([
                    frame.topAnchor.constraint(equalTo:  contentFrame.topAnchor),
                    frame.leftAnchor.constraint(equalTo: contentFrame.leftAnchor)
                    ])
                frame.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor).isActive = count < 6 ? true : false
            }  else {
                NSLayoutConstraint.activate([
                    frame.topAnchor.constraint(equalTo:  contentFrame.topAnchor),
                    frame.leftAnchor.constraint(equalTo: previousFrame.rightAnchor, constant: 3),
                    frame.widthAnchor.constraint(equalTo: previousFrame.widthAnchor),
                    frame.heightAnchor.constraint(equalTo: previousFrame.heightAnchor)
                    ])
                frame.rightAnchor.constraint(equalTo: contentFrame.rightAnchor).isActive = i == 4 ? true : false
                frame.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor).isActive = count < 6 ? true : false
            }
            previousFrame = frame
            if count == 6 {
                frames.append(frame)
            }
        }
    }
  
    func mediumRowsFrames(_ m: Int, _ s: Int) {
        for i in 0 ..< s {
            let frame = FrameView()
            frame.translatesAutoresizingMaskIntoConstraints = false
            contentFrame.addSubview(frame)
            fillNumber(frame, 5*m + i)
            if i == 0 {
                NSLayoutConstraint.activate([
                    frame.topAnchor.constraint(equalTo:   frames[0].bottomAnchor, constant: 10),
                    frame.leftAnchor.constraint(equalTo:  contentFrame.leftAnchor),
                    frame.heightAnchor.constraint(equalTo: frames[0].heightAnchor)
                    ])
                frame.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor).isActive = s < 5 ? true : false
                if s == 5 {
                    frames[0] = frame
                }
            } else {
                NSLayoutConstraint.activate([
                    frame.topAnchor.constraint(equalTo:  frames[i].bottomAnchor, constant: 10),
                    frame.heightAnchor.constraint(equalTo:frames[i].heightAnchor),
                    frame.leftAnchor.constraint(equalTo: previousFrame.rightAnchor, constant: 3),
                    frame.widthAnchor.constraint(equalTo: previousFrame.widthAnchor)
                    ])
                frame.rightAnchor.constraint(equalTo: contentFrame.rightAnchor).isActive = i == 4 ? true : false
                frame.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor).isActive = s < 5 ? true : false
                if s == 5 {
                    frames[i] = frame
                }
            }
            previousFrame = frame
        }
    }
    
    func finalFrame(_ g: Int) {
        let finalFrame = FinalFrameView()
        finalFrame.translatesAutoresizingMaskIntoConstraints = false
        contentFrame.addSubview(finalFrame)
        fillNumber(finalFrame, countFrame)
        
        NSLayoutConstraint.activate([
            finalFrame.rightAnchor.constraint(equalTo: contentFrame.rightAnchor),
            finalFrame.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor)
            ])
        if g > 0 {
            finalFrame.topAnchor.constraint(equalTo:  frames[g-1].bottomAnchor, constant: 10).isActive = true
            finalFrame.heightAnchor.constraint(equalTo:frames[g-1].heightAnchor).isActive = true
        }
        finalFrame.topAnchor.constraint(equalTo:  contentFrame.topAnchor).isActive = g == 0 ? true : false
        finalFrame.leftAnchor.constraint(equalTo: previousFrame.rightAnchor, constant: 3).isActive = g > 1 || g == 0 ? true : false
        finalFrame.leftAnchor.constraint(equalTo: contentFrame.leftAnchor).isActive = g == 1 ? true : false
        finalFrame.widthAnchor.constraint(equalTo: previousFrame.widthAnchor).isActive = g > 1 || g == 0 ? true : false
    }
    
    func fillNumber(_ frameType: UIView, _ i: Int) {
        let firstScore: Int = Int(arc4random() % 10)
        let secondScore: Int = 10 - firstScore
        
        if frameType is FinalFrameView  {
            let thirdScore: Int = 0
            let frame = frameType as! FinalFrameView
            frame.configureFinalFrame(frameNumber: i, firstThrowScore: firstScore , secondThrowScore: secondScore, thirdThrowScore: thirdScore,
                                      finalScore: 0)
        } else {
            let frame = frameType as! FrameView
            frame.configureFrame(frameNumber: i + 1, firstThrowScore: firstScore , secondThrowScore: secondScore,                                           finalScore: 0)
        }
    }
}
