//
//  GameSessionViewController.swift
//  Bowling
//
//  Created by Ihar_Karalko on 31.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit

class GameSessionViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    let countOfPlayers: Int = 3
    var previuosGame = GameView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for a in 1 ... countOfPlayers {
            let gameView = GameView()
            let gameViewModel = GameViewModel()
            gameView.viewModel = gameViewModel
            
            scrollView.addSubview(gameView)
            gameView.translatesAutoresizingMaskIntoConstraints = false
            if a == 1 {
                NSLayoutConstraint.activate([
                    gameView.topAnchor.constraint(equalTo:   scrollView.topAnchor, constant: 10),
                    gameView.leadingAnchor.constraint(equalTo:  scrollView.leadingAnchor),
                    gameView.trailingAnchor.constraint(equalTo:  scrollView.trailingAnchor),
                    gameView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
                    ])
            } else {
                NSLayoutConstraint.activate([
                    gameView.topAnchor.constraint(equalTo:   previuosGame.bottomAnchor, constant: 20),
                    gameView.leadingAnchor.constraint(equalTo:  scrollView.leadingAnchor),
                    gameView.trailingAnchor.constraint(equalTo:  scrollView.trailingAnchor),
                    gameView.heightAnchor.constraint(equalTo: previuosGame.heightAnchor),
                    gameView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
                    ])
                if a == countOfPlayers {
                    gameView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
                }
            }
            previuosGame = gameView
        }
    }
}
