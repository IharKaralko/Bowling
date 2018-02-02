//
//  GameView.swift
//  Bowling
//
//  Created by Ihar_Karalko on 30.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit

class GameView: UIView {
   
    
    var viewModel: GameViewModel = GameViewModel()
    
    @IBAction func tappedButton(_ sender: UIButton) {
        let index =  buttonsCollection.index(of: sender)
        
        
        if let indexx = index{
            let r = Int(indexx)
            scoresOfFrame(r)
            activateButtonCollection()
            //  print(r)
        }
    }
    
    var bowls: [Int] = []
    var m: Int = 0
    var gameFrames: [FrameView] = []
    var gameFinalFrame: FinalFrameView = FinalFrameView()
    
    let countFrame = 4
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
            gameFrames.append(frame)
            frame.translatesAutoresizingMaskIntoConstraints = false
            contentFrame.addSubview(frame)
       //    frame.numberFrame.text = i.description
             numberFrame(frame, i + 1)
            
            if i == 0 {
                NSLayoutConstraint.activate([
                    frame.topAnchor.constraint(equalTo:  contentFrame.topAnchor),
                    frame.leftAnchor.constraint(equalTo: contentFrame.leftAnchor)
                    ])
                frame.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor).isActive = count < countFramesInRow + 1  ? true : false
            }  else {
                NSLayoutConstraint.activate([
                    frame.topAnchor.constraint(equalTo:  contentFrame.topAnchor),
                    frame.leftAnchor.constraint(equalTo: previousFrame.rightAnchor, constant: 3),
                    frame.widthAnchor.constraint(equalTo: previousFrame.widthAnchor),
                    frame.heightAnchor.constraint(equalTo: previousFrame.heightAnchor)
                    ])
                frame.rightAnchor.constraint(equalTo: contentFrame.rightAnchor).isActive = i == 4 ? true : false
                frame.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor).isActive = count < countFramesInRow + 1 ? true : false
            }
            previousFrame = frame
            if count == countFramesInRow + 1 {
                frames.append(frame)
            }
        }
    }
  
    func mediumRowsFrames(_ m: Int, _ s: Int) {
        for i in 0 ..< s {
            let frame = FrameView()
            gameFrames.append(frame)
            frame.translatesAutoresizingMaskIntoConstraints = false
            contentFrame.addSubview(frame)
          //  fillNumber(frame, 5*m + i + 1)
             numberFrame(frame, countFramesInRow * m + i + 1)
            if i == 0 {
                NSLayoutConstraint.activate([
                    frame.topAnchor.constraint(equalTo:   frames[0].bottomAnchor, constant: 10),
                    frame.leftAnchor.constraint(equalTo:  contentFrame.leftAnchor),
                    frame.heightAnchor.constraint(equalTo: frames[0].heightAnchor)
                    ])
                frame.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor).isActive = s < countFramesInRow ? true : false
                if s == countFramesInRow {
                    frames[0] = frame
                }
            } else {
                NSLayoutConstraint.activate([
                    frame.topAnchor.constraint(equalTo:  frames[i].bottomAnchor, constant: 10),
                    frame.heightAnchor.constraint(equalTo:frames[i].heightAnchor),
                    frame.leftAnchor.constraint(equalTo: previousFrame.rightAnchor, constant: 3),
                    frame.widthAnchor.constraint(equalTo: previousFrame.widthAnchor)
                    ])
                frame.rightAnchor.constraint(equalTo: contentFrame.rightAnchor).isActive = i == countFramesInRow - 1 ? true : false
                frame.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor).isActive = s < countFramesInRow ? true : false
                if s == countFramesInRow {
                    frames[i] = frame
                }
            }
            previousFrame = frame
        }
    }
    
    func finalFrame(_ g: Int) {
        let finalFrame = FinalFrameView()
        gameFinalFrame = finalFrame
        finalFrame.translatesAutoresizingMaskIntoConstraints = false
        contentFrame.addSubview(finalFrame)
       // fillNumber(finalFrame, countFrame)
         numberFrame(finalFrame, countFrame)
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
    
//    func fillNumber(_ frameType: UIView, _ i: Int) {
//        let firstScore: Int = Int(arc4random() % 10)
//        let secondScore: Int = 10 - firstScore
//
//        if frameType is FinalFrameView  {
//            let thirdScore: Int = 0
//            let frame = frameType as! FinalFrameView
//            frame.configureFinalFrame(frameNumber: i, firstThrowScore: firstScore , secondThrowScore: secondScore, thirdThrowScore: thirdScore,
//                                      finalScore: 0)
//        } else {
//            let frame = frameType as! FrameView
//            frame.configureFrame(frameNumber: i + 1, firstThrowScore: firstScore , secondThrowScore: secondScore,                                           finalScore: 0)
//        }
//    }
    
    func numberFrame(_ frame: FrameViewProtocol, _ i: Int){
        
        frame.fillNumberFrame(frameNumber: i)
        
    }
    
//    var bowls: [Int] = []
//    var m: Int = 0
//    var gameFrames: [FrameView] = []
//    var gameFinalFrame: FinalFrameView = FinalFrameView()
    
    func scoresOfFrame(_ score: Int) -> Bool {
        if m < countFrame - 1 {
            if bowls.isEmpty {
//                for w in 0 ... 10{
//                buttonsCollection[w].isEnabled = true
//                    buttonsCollection[w].backgroundColor = UIColor.cyan
//                  }
                bowls.append(score)
                gameFrames[m].fillFirstScoreFrame(firstThrowScore: score)
                if score == 10 {
                    
                    gameFrames[m].fillSecondScoreFrame(secondThrowScore: 10)
                    m += 1
                    bowls = []
                }
                return true
            }
            
            if bowls.first! + score == 10 {
                gameFrames[m].fillSecondScoreFrame(secondThrowScore: 11)
                m += 1
                bowls = []
                return true
            }
            if bowls.first! + score < 10 {
                gameFrames[m].fillSecondScoreFrame(secondThrowScore: score)
                m += 1
                bowls = []
                return true
                
            }  else {
                return false
            }
        } else {
            
             if bowls.isEmpty {
                gameFinalFrame.fillFirstScoreFinalFrame(firstThrowScore: score)
                bowls.append(score)
            return true
                         }
             else if bowls.count == 1 {
                
          return  secondThrowFinalFrame(score: score)
             } else if bowls.count == 2 {
                 return thirdThrowFinalFrame(score: score)
            }
             else { return false}
            
        }
            
        }

    
    func secondThrowFinalFrame(score: Int) -> Bool {
       
            if bowls.first! == 10 {
                gameFinalFrame.fillSecondScoreFinalFrame(secondThrowScore: score)
                bowls.append(score)
                return true
            } else {
                if bowls.first! + score == 10 {
                    gameFinalFrame.fillSecondScoreFinalFrame(secondThrowScore: 11)
                    bowls.append(score)
                    return true
                }
                if bowls.first! + score < 10 {
                    gameFinalFrame.fillSecondScoreFinalFrame(secondThrowScore: score)
                    bowls.append(score)
                    return true
                }
                return false
            }
       
    }

    func thirdThrowFinalFrame(score: Int) -> Bool {
        if bowls.first! == 10{
            
         if bowls.reduce(0,+) == 20 {
             gameFinalFrame.fillThirdtScoreFinalFrame(thirdThrowScore: score)
            bowls.append(score)
              return true //////
            } else if bowls.reduce(0,+) + score < 21 {
             gameFinalFrame.fillThirdtScoreFinalFrame(thirdThrowScore: score)
             bowls.append(score)
            return true   ///////
        }
        return false
        
        } else if bowls.reduce(0,+) == 10{
            gameFinalFrame.fillThirdtScoreFinalFrame(thirdThrowScore: score)
             bowls.append(score)
            return true
            
        }
            return false
       
        
    }
    
    func activateButtonCollection(){

        if bowls.isEmpty{
            for w in 0 ... 10{
                buttonsCollection[w].isEnabled = true
                buttonsCollection[w].backgroundColor = UIColor.cyan
            }
        } else if m < countFrame - 1 {
            if bowls.first! != 0{
                for w in 10 - bowls.first! + 1 ... 10{
                    buttonsCollection[w].isEnabled = false
                    buttonsCollection[w].backgroundColor = UIColor.white
                }
            }
        } else {
            if  bowls.first! == 10 || bowls.reduce(0,+) == 10 || bowls.reduce(0,+) == 20 {
            for w in 0 ... 10{
                    buttonsCollection[w].isEnabled = true
                    buttonsCollection[w].backgroundColor = UIColor.cyan
                }
                
            }
            
            if bowls.reduce(0,+) < 10{
                if bowls.first! != 0{
                    for w in 10 - bowls.first! + 1 ... 10{
                    buttonsCollection[w].isEnabled = false
                    buttonsCollection[w].backgroundColor = UIColor.white
                }
                }
            }
        }
    }
}

            
            
            
            
            
//            if
//            bowls.first! == 10  || bowls.reduce(0,+) == 20 || bowls.reduce(0,+) == 10
//        {
//            for w in 0 ... 10{
//                buttonsCollection[w].isEnabled = true
//                buttonsCollection[w].backgroundColor = UIColor.cyan
//            }
//
//
//        } else
//
//
//        }
//    }


    

            
//if typeOfFrame == .strike {
//    if throwScore.reduce(0,+) == 20 {
//        throwScore.append(score)
//        return true
//    } else if throwScore.reduce(0,+) + score < 21 {
//        throwScore.append(score)
//        return true
//    }
//    return false
//} else if typeOfFrame == .spare {
//    throwScore.append(score)
//    return true
//}
//return false
//}


    

