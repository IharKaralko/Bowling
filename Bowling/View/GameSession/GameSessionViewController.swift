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
    let countOfPlayers: Int = 10
    var previuosGame = GameView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for a in 1 ... countOfPlayers {
            let game = GameView()
            scrollView.addSubview(game)
            game.translatesAutoresizingMaskIntoConstraints = false
            if a == 1 {
                NSLayoutConstraint.activate([
                    game.topAnchor.constraint(equalTo:   scrollView.topAnchor, constant: 10),
                    game.leadingAnchor.constraint(equalTo:  scrollView.leadingAnchor),
                    game.trailingAnchor.constraint(equalTo:  scrollView.trailingAnchor),
                    game.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
                    ])
            } else {
                NSLayoutConstraint.activate([
                    game.topAnchor.constraint(equalTo:   previuosGame.bottomAnchor, constant: 20),
                    game.leadingAnchor.constraint(equalTo:  scrollView.leadingAnchor),
                    game.trailingAnchor.constraint(equalTo:  scrollView.trailingAnchor),
                    game.heightAnchor.constraint(equalTo: previuosGame.heightAnchor),
                    game.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
                    ])
                game.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = a == countOfPlayers ? true : false
            }
            previuosGame = game
        }
    }
}
