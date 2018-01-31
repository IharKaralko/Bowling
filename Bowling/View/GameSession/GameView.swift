//
//  GameView.swift
//  Bowling
//
//  Created by Ihar_Karalko on 30.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit

class GameView: UIView {
    
    let l = 23
    var previousFrame = FrameView()
    var frames: [FrameView] = []
    
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
        var k = l%5 == 0 ? l/5 : Int(l/5) + 1
  
        if k == 1 {
            oneRowFrames()
            
            //            for i in 0 ..< l - 1 {
//                let frame = FrameView()
//
//                let firstScore: Int = Int(arc4random() % 10)
//                let secondScore: Int = 10 - firstScore
//                frame.configureFrame(frameNumber: i + 1, firstThrowScore: firstScore , secondThrowScore: secondScore,                                           finalScore: 0)
//
//                frame.translatesAutoresizingMaskIntoConstraints = false
//              contentFrame.addSubview(frame)
//                //frames.append(frame)
//
//                if i == 0 {
//                      NSLayoutConstraint.activate([
//                        frame.topAnchor.constraint(equalTo:  contentFrame.topAnchor),
//                        frame.leftAnchor.constraint(equalTo: contentFrame.leftAnchor),
//                        frame.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor)
//                        ])
//                }
////                else if i == l - 1 {
////                      NSLayoutConstraint.activate([
////                        frame.topAnchor.constraint(equalTo:  contentFrame.topAnchor),
////                        frame.leftAnchor.constraint(equalTo: previousFrame.rightAnchor, constant: 3),
////                        frame.rightAnchor.constraint(equalTo: contentFrame.rightAnchor),
////                        frame.widthAnchor.constraint(equalTo: previousFrame.widthAnchor),
////                        frame.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor)
////                        ])
////                }
//                else {
//                   NSLayoutConstraint.activate([
//                        frame.topAnchor.constraint(equalTo:  contentFrame.topAnchor),
//                        frame.leftAnchor.constraint(equalTo: previousFrame.rightAnchor, constant: 3),
//                        frame.widthAnchor.constraint(equalTo: previousFrame.widthAnchor),
//                        frame.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor)
//                        ])
//                }
//                previousFrame = frame
//            }
            
            let finalFrame = FinalFrameView()
            
            let firstScore: Int = Int(arc4random() % 10)
            let secondScore: Int = 10 - firstScore
            let thirdScore: Int = 0
            finalFrame.configureFinalFrame(frameNumber: l, firstThrowScore: firstScore , secondThrowScore: secondScore, thirdThrowScore: thirdScore,
                                           finalScore: 0)
            
            finalFrame.translatesAutoresizingMaskIntoConstraints = false
            contentFrame.addSubview(finalFrame)
            NSLayoutConstraint.activate([
                finalFrame.topAnchor.constraint(equalTo:  contentFrame.topAnchor),
                finalFrame.leftAnchor.constraint(equalTo: previousFrame.rightAnchor, constant: 3),
                finalFrame.rightAnchor.constraint(equalTo: contentFrame.rightAnchor),
                finalFrame.widthAnchor.constraint(equalTo: previousFrame.widthAnchor),
                finalFrame.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor)
                ])
        } else {
            for m in 1 ... k {
                
                if m == 1 {
                    
                    for i in 0 ..< 5 {
                        let frame = FrameView()
                        
                        let firstScore: Int = Int(arc4random() % 10)
                        let secondScore: Int = 10 - firstScore
                        frame.configureFrame(frameNumber: i + 1, firstThrowScore: firstScore , secondThrowScore: secondScore,                                           finalScore: 0)
                        
                        frame.translatesAutoresizingMaskIntoConstraints = false
                        contentFrame.addSubview(frame)
                        
                        
                        if i == 0 {
                            NSLayoutConstraint.activate([
                                frame.topAnchor.constraint(equalTo:  contentFrame.topAnchor),
                                frame.leftAnchor.constraint(equalTo: contentFrame.leftAnchor),
                               // frame.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor)
                                ])
                        }
                        else if i == 4 {
                            NSLayoutConstraint.activate([
                                frame.topAnchor.constraint(equalTo:  contentFrame.topAnchor),
                                frame.leftAnchor.constraint(equalTo: previousFrame.rightAnchor, constant: 3),
                                frame.rightAnchor.constraint(equalTo: contentFrame.rightAnchor),
                                frame.widthAnchor.constraint(equalTo: previousFrame.widthAnchor),
                                 frame.heightAnchor.constraint(equalTo: previousFrame.heightAnchor),
                                 //frame.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor)
                                ])
                        }
                        else {
                            NSLayoutConstraint.activate([
                                frame.topAnchor.constraint(equalTo:  contentFrame.topAnchor),
                                frame.leftAnchor.constraint(equalTo: previousFrame.rightAnchor, constant: 3),
                                frame.widthAnchor.constraint(equalTo: previousFrame.widthAnchor),
                                frame.heightAnchor.constraint(equalTo: previousFrame.heightAnchor),
                                //frame.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor)
                                ])
                        }
                        previousFrame = frame
                        frames.append(frame)
                    }
                }
                else if m < k {
                    for i in 0 ..< 5 {
                       
                        let frame = FrameView()
                        
                        let firstScore: Int = Int(arc4random() % 10)
                        let secondScore: Int = 10 - firstScore
                        frame.configureFrame(frameNumber: i + 1, firstThrowScore: firstScore , secondThrowScore: secondScore,                                           finalScore: 0)
                        
                        frame.translatesAutoresizingMaskIntoConstraints = false
                        contentFrame.addSubview(frame)
                        if i == 0 {
                            NSLayoutConstraint.activate([
                                frame.topAnchor.constraint(equalTo:  frames[0].bottomAnchor),
                                frame.leftAnchor.constraint(equalTo: contentFrame.leftAnchor),
                                frame.heightAnchor.constraint(equalTo:frames[0].heightAnchor),
                                // frame.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor)
                                ])
                            frames[0] = frame
                        }
                        else if i == 4 {
                            NSLayoutConstraint.activate([
                                frame.topAnchor.constraint(equalTo:frames[4].bottomAnchor),
                                 frame.heightAnchor.constraint(equalTo:frames[4].heightAnchor),
                                 frame.leftAnchor.constraint(equalTo: previousFrame.rightAnchor, constant: 3),
                                frame.rightAnchor.constraint(equalTo: contentFrame.rightAnchor),
                                frame.widthAnchor.constraint(equalTo: previousFrame.widthAnchor),
                                //frame.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor)
                                ])
                            frames[4] = frame
                            
                        }
                        else {
                            NSLayoutConstraint.activate([
                                frame.topAnchor.constraint(equalTo:  frames[i].bottomAnchor),
                                 frame.heightAnchor.constraint(equalTo:frames[i].heightAnchor),
                                 frame.leftAnchor.constraint(equalTo: previousFrame.rightAnchor, constant: 3),
                                frame.widthAnchor.constraint(equalTo: previousFrame.widthAnchor),
                                //frame.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor)
                                ])
                            frames[i] = frame
                        }
                        previousFrame = frame
                        
                    }
                    
                }
                else{
                    let g = l - 5*(k-1)
                    
                    if g > 1{
                        
                        for i in 0 ... g - 2 {
                            let frame = FrameView()
                            
                            let firstScore: Int = Int(arc4random() % 10)
                            let secondScore: Int = 10 - firstScore
                            frame.configureFrame(frameNumber: i + 1, firstThrowScore: firstScore , secondThrowScore: secondScore,                                           finalScore: 0)
                            
                            frame.translatesAutoresizingMaskIntoConstraints = false
                            contentFrame.addSubview(frame)
                            if i == 0 {
                                NSLayoutConstraint.activate([
                                    frame.topAnchor.constraint(equalTo:  frames[0].bottomAnchor),
                                    frame.heightAnchor.constraint(equalTo:frames[0].heightAnchor),
                                    frame.leftAnchor.constraint(equalTo: contentFrame.leftAnchor),
                                    frame.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor)
                                    ])
                                // frames[0] = frame
                            }
                                //                        else if i == 4 {
                                //                            NSLayoutConstraint.activate([
                                //                                frame.topAnchor.constraint(equalTo:frames[4].bottomAnchor),
                                //                                frame.leftAnchor.constraint(equalTo: previousFrame.rightAnchor, constant: 3),
                                //                                frame.rightAnchor.constraint(equalTo: contentFrame.rightAnchor),
                                //                                frame.widthAnchor.constraint(equalTo: previousFrame.widthAnchor),
                                //                                //frame.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor)
                                //                                ])
                                //                            frames[4] = frame
                                //
                                //                        }
                            else {
                                NSLayoutConstraint.activate([
                                    frame.topAnchor.constraint(equalTo:  frames[i].bottomAnchor),
                                    frame.heightAnchor.constraint(equalTo:frames[i].heightAnchor),
                                    frame.leftAnchor.constraint(equalTo: previousFrame.rightAnchor, constant: 3),
                                    frame.widthAnchor.constraint(equalTo: previousFrame.widthAnchor),
                                    frame.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor)
                                    ])
                                // frames[i] = frame
                            }
                            previousFrame = frame
                            
                            
                        }
                        let finalFrame = FinalFrameView()
                        
                        let firstScore: Int = Int(arc4random() % 10)
                        let secondScore: Int = 10 - firstScore
                        let thirdScore: Int = 0
                        finalFrame.configureFinalFrame(frameNumber: l, firstThrowScore: firstScore , secondThrowScore: secondScore, thirdThrowScore: thirdScore,
                                                       finalScore: 0)
                        
                        finalFrame.translatesAutoresizingMaskIntoConstraints = false
                        contentFrame.addSubview(finalFrame)
                        NSLayoutConstraint.activate([
                            finalFrame.topAnchor.constraint(equalTo:  frames[g-1].bottomAnchor),
                            finalFrame.heightAnchor.constraint(equalTo:frames[g-1].heightAnchor),
                            finalFrame.leftAnchor.constraint(equalTo: previousFrame.rightAnchor, constant: 3),
                            finalFrame.rightAnchor.constraint(equalTo: contentFrame.rightAnchor),
                            finalFrame.widthAnchor.constraint(equalTo: previousFrame.widthAnchor),
                            finalFrame.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor)
                            ])
                        
                        
                    }
                    else {
                        let finalFrame = FinalFrameView()
                        
                        let firstScore: Int = Int(arc4random() % 10)
                        let secondScore: Int = 10 - firstScore
                        let thirdScore: Int = 0
                        finalFrame.configureFinalFrame(frameNumber: l, firstThrowScore: firstScore , secondThrowScore: secondScore, thirdThrowScore: thirdScore,
                                                       finalScore: 0)
                        
                        finalFrame.translatesAutoresizingMaskIntoConstraints = false
                        contentFrame.addSubview(finalFrame)
                        NSLayoutConstraint.activate([
                            finalFrame.topAnchor.constraint(equalTo:  frames[g-1].bottomAnchor),
                            finalFrame.heightAnchor.constraint(equalTo:frames[g-1].heightAnchor),
                        //    finalFrame.leftAnchor.constraint(equalTo: previousFrame.rightAnchor, constant: 3),
                            finalFrame.leftAnchor.constraint(equalTo: contentFrame.leftAnchor),
                            finalFrame.rightAnchor.constraint(equalTo: contentFrame.rightAnchor),
                           // finalFrame.widthAnchor.constraint(equalTo: previousFrame.widthAnchor),
                            finalFrame.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor)
                            ])
                        
                    }
                    
                }
                
            }
            
        }
        
        
        
    }
    
}
extension GameView {
    
    func oneRowFrames() {
        
        for i in 0 ..< l - 1 {
            let frame = FrameView()
            
            let firstScore: Int = Int(arc4random() % 10)
            let secondScore: Int = 10 - firstScore
            frame.configureFrame(frameNumber: i + 1, firstThrowScore: firstScore , secondThrowScore: secondScore,                                           finalScore: 0)
            
            frame.translatesAutoresizingMaskIntoConstraints = false
            contentFrame.addSubview(frame)
            
            
            if i == 0 {
                NSLayoutConstraint.activate([
                    frame.topAnchor.constraint(equalTo:  contentFrame.topAnchor),
                    frame.leftAnchor.constraint(equalTo: contentFrame.leftAnchor),
                    frame.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor)
                    ])
            } else {
                NSLayoutConstraint.activate([
                    frame.topAnchor.constraint(equalTo:  contentFrame.topAnchor),
                    frame.leftAnchor.constraint(equalTo: previousFrame.rightAnchor, constant: 3),
                    frame.widthAnchor.constraint(equalTo: previousFrame.widthAnchor),
                    frame.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor)
                    ])
            }
            previousFrame = frame
        }
    }
}
    
    
    
    
    
    
    
    
    
    
    
    
    
//        for i in 0 ..< k {
//            let frame = FrameView()
//
//            let firstScore: Int = Int(arc4random() % 10)
//            let secondScore: Int = 10 - firstScore
//            frame.configure(frameNumber: i + 1, firstThrowScore: firstScore , secondThrowScore: secondScore, finalScore: 0)
//
//            frame.translatesAutoresizingMaskIntoConstraints = false
//            contentFrame.addSubview(frame)
//            //frames.append(frame)
//
//            if i == 0 {
//                NSLayoutConstraint.activate([
//                    frame.topAnchor.constraint(equalTo:  contentFrame.topAnchor),
//                    frame.leftAnchor.constraint(equalTo: contentFrame.leftAnchor),
//                    frame.bottomAnchor.constraint(equalTo: contentFrame.bottomAnchor)
//                    ])

   //         } else if i == k - 1 {
//                NSLayoutConstraint.activate([
//                    frame.topAnchor.constraint(equalTo:  placeOfFrame.topAnchor),
//                    frame.leftAnchor.constraint(equalTo: frames[i-1].rightAnchor, constant: 3),
//                    frame.rightAnchor.constraint(equalTo: placeOfFrame.rightAnchor),
//                    frame.widthAnchor.constraint(equalTo: frames[i-1].widthAnchor),
//                    frame.bottomAnchor.constraint(equalTo: placeOfFrame.bottomAnchor)
//                    ])
     //       } else {
//                NSLayoutConstraint.activate([
//                    frame.topAnchor.constraint(equalTo:  placeOfFrame.topAnchor),
//                    frame.leftAnchor.constraint(equalTo: frames[i-1].rightAnchor, constant: 3),
//                    frame.widthAnchor.constraint(equalTo: frames[i-1].widthAnchor),
//                    frame.bottomAnchor.constraint(equalTo: placeOfFrame.bottomAnchor)
//                    ])
       //     }

        //}
    
//}
