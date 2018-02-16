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
        viewModel.delegate = self
        commonInit()
    }
}

private extension GameSessionViewController {
      func bindViewModel() {
        guard isViewLoaded else { return }
     }
    
    func commonInit(){
        var previuosGame: GameView?
        for index in 0 ..< viewModel.namesOfPlayer.count {
            let gameView = GameView()
            let gameViewModel = viewModel.gamesModels[index]
            gameView.viewModel = gameViewModel
            scrollView.addSubview(gameView)
            gameView.translatesAutoresizingMaskIntoConstraints = false
            if index == 0 {
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
                if index == viewModel.namesOfPlayer.count - 1{
                    gameView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
                }
            }
            previuosGame = gameView
        }
    }
    
    @objc
    func doneBack(){
         viewModel.doneBack()
    }
}

extension GameSessionViewController:  GameSessionViewModelStateGame{
    func alertGameSessionCompleted(_ index: Int){
        let alertController = UIAlertController(title: "Game Session is completed", message: "Player \(viewModel.namesOfPlayer[index])  with a score \(viewModel.gamesModels[index].game.scoreGame)  WON!", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
}
