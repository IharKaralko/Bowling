//
//  GameSessionViewController.swift
//  Bowling
//
//  Created by Ihar_Karalko on 31.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result
import ReactiveCocoa

class GameSessionViewController: UIViewController {
    
    deinit {
        print("GameSessionViewController deinit")
    }
    
    @IBOutlet private weak var scrollView: UIScrollView!
    private let _pipe = Signal<(), NoError>.pipe()
    
    var viewModel: GameSessionViewModelProtocol! {
        didSet {
            bindViewModel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackButton()
        commonInit()
        bindViewModel()
     }
 
    override func viewWillAppear(_ animated: Bool) {
        let bag = CompositeDisposable()
        let notificationCenter = NotificationCenter.default.reactive
        
        bag += notificationCenter.notifications(forName: .UIApplicationDidEnterBackground)
            .observeValues{ [weak self] notification in self?.saveResultsOfGameSession(notification: notification )}
        bag += notificationCenter.notifications(forName: .UIApplicationWillResignActive)
            .observeValues{ [weak self] notification in self?.saveResultsOfGameSession(notification: notification )}
        bag +=  notificationCenter.notifications(forName: .UIApplicationWillTerminate)
            .observeValues{ [weak self] notification in self?.saveResultsOfGameSession(notification: notification )}
        _pipe.output.observeValues { bag.dispose() }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
         super.viewDidDisappear(animated)
        _pipe.input.send(value: ())
    }
    
    
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
        viewModel.refreshScoreGameOfPlayers()
    }
}

private extension GameSessionViewController {
    func bindViewModel() {
        guard isViewLoaded else { return }
        viewModel.output.observeValues{ [weak self] value in
            switch value {
            case .gameSessionCompleted(let index):
                self?.alertGameSessionCompleted(index)
            }
        }
    }
    
    func saveResultsOfGameSession(notification: Notification){
        viewModel.refreshScoreGameOfPlayers()
    }
    
    func setupBackButton(){
        let done = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        done.reactive.pressed = CocoaAction(viewModel.doneCancelAction)
        navigationItem.setLeftBarButton(done, animated: false)
    }
    
    func commonInit(){
        var previuosGame: GameView?
        for index in 0 ..< viewModel.configurationCurrentGame.namesOfPlayer.count {
            let gameView = GameView()
            let gameViewModel = viewModel.gamesModelsOfGameSession[index]
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
                if index == viewModel.configurationCurrentGame.namesOfPlayer.count - 1{
                    gameView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
                }
            }
            previuosGame = gameView
        }
    }
    
    func alertGameSessionCompleted(_ index: Int){        
        let alertController = UIAlertController(title: "Game Session is completed", message: "Player \(viewModel.configurationCurrentGame.namesOfPlayer[index])  with a score \(viewModel.gamesModelsOfGameSession[index].currentGame.score)  WON!", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension GameSessionViewController {
    enum Action {
        case gameSessionCompleted(index: Int)
    }
}
