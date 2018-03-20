//
//  GameHistoryViewController.swift
//  Bowling
//
//  Created by Ihar_Karalko on 13.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result
import ReactiveCocoa

class GameHistoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    deinit {
        print("\(type(of: self)).\(#function)")
    }
    
    var viewModel: GameHistoryViewModelProtocol! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        setupBarButton()
    }
}

// MARK: - Private methods
private extension GameHistoryViewController {
    func commonInit() {
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib.init(nibName: "GameHistoryTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "GameHistoryTableViewCell")
    }
    
    func setupBarButton(){
        self.navigationItem.title = "GAMES"
        let done = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        done.reactive.pressed = CocoaAction(viewModel.backCancelAction)
        navigationItem.setLeftBarButton(done, animated: false)
    }
}

// MARK: - UITableViewDataSource
extension GameHistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.gamesHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameHistoryTableViewCell", for: indexPath) as! GameHistoryTableViewCell
        cell.configureCell(viewModel.gamesHistory[indexPath.row].date.description, "\(viewModel.gamesHistory[indexPath.row].countOfPlayers) Players")
        return cell
    }
}

extension GameHistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let currentGame = viewModel.gamesHistory[index]
       viewModel.selectGameHistory(currentLocation: currentGame)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
