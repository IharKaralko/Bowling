//
//  PlayersViewController.swift
//  Bowling
//
//  Created by Ihar_Karalko on 13.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

class PlayersViewController: UIViewController {
    
    deinit {
        print("\(type(of: self)).\(#function)")
    }
   
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: PlayersViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        setupBarButton()
    }
}

// MARK: - Private methods
private extension PlayersViewController {
    func commonInit() {
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib.init(nibName: "PlayersTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "PlayersTableViewCell")
    }
    
    func setupBarButton() {
        self.navigationItem.title = "PlAYERS RESULT"
        let done = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        done.reactive.pressed = CocoaAction(viewModel.backCancelAction)
        navigationItem.setLeftBarButton(done, animated: false)
    }
}

// MARK: - UITableViewDataSource
extension PlayersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.playersOfGame.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayersTableViewCell", for: indexPath) as! PlayersTableViewCell
        cell.configureCell(viewModel.playersOfGame[indexPath.row].name, viewModel.playersOfGame[indexPath.row].scoreGame.description)
        return cell
    }
}

extension PlayersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
