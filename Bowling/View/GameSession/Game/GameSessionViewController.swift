//
//  GameSessionViewController.swift
//  Bowling
//
//  Created by Ihar_Karalko on 31.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit

class GameSessionViewController: UIViewController {
    
    deinit {
        print("GameSessionViewController deinit")
    }
    @IBOutlet weak var scrollView: UIScrollView!
    var viewModel: GameSessionViewModel! {
        didSet {
            bindViewModel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let done = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(doneBack))
        navigationItem.setLeftBarButton(done, animated: false)
        
        var previuosGame: GameView?
        for player in 0 ..< viewModel.names.count {
            
//            let frameView = FrameView()
//            let frameViewModel = viewModel.framesViewModel[i]
//            frameView.frameViewModel = frameViewModel
            
            
            let gameView = GameView()
            let gameViewModel = viewModel.gamesModels[player]
            
            gameView.viewModel = gameViewModel
            gameView.namePlayer.text = viewModel.names[player] // TODO: Need refactor
            
            scrollView.addSubview(gameView)
            gameView.translatesAutoresizingMaskIntoConstraints = false
            if player == 0 {
                NSLayoutConstraint.activate([
                    gameView.topAnchor.constraint(equalTo:   scrollView.topAnchor, constant: 10),
                    gameView.leadingAnchor.constraint(equalTo:  scrollView.leadingAnchor),
                    gameView.trailingAnchor.constraint(equalTo:  scrollView.trailingAnchor),
                    gameView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
                    ])
            } else {
                if let previuosGame = previuosGame {
                    NSLayoutConstraint.activate([
                        gameView.topAnchor.constraint(equalTo:   previuosGame.bottomAnchor, constant: 20),
                        gameView.leadingAnchor.constraint(equalTo:  scrollView.leadingAnchor),
                        gameView.trailingAnchor.constraint(equalTo:  scrollView.trailingAnchor),
                        gameView.heightAnchor.constraint(equalTo: previuosGame.heightAnchor),
                        gameView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
                        ])
                }
                if player == viewModel.names.count - 1{
                    gameView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
                }
            }
            previuosGame = gameView
        }
    }
}
private extension GameSessionViewController {
      func bindViewModel() {
        guard isViewLoaded else { return }
    }
    
    @objc
    func doneBack(){
         viewModel.doneBack()
    }
}
