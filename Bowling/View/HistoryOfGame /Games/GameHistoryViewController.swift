//
//  GameHistoryViewController.swift
//  Bowling
//
//  Created by Ihar_Karalko on 13.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit

class GameHistoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    deinit {
        print("GameHistoryViewController deinit--------")
    }
    
    var viewModel: GameHistoryViewModelProtocol! // = GameHistoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        commonInit()
        setupBarButton()
    }
 }

// MARK: - Private methods
private extension GameHistoryViewController {
    func bindViewModel() {
        guard isViewLoaded else { return }
    }
    func commonInit() {
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib.init(nibName: "GameHistoryTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "GameHistoryTableViewCell")
        // self.hideKeyboard()
        
    }
    func setupBarButton(){
        self.navigationItem.title = "GAMES"
        
        let done = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        //done.reactive.pressed = CocoaAction(viewModel.backCancelAction)
        navigationItem.setLeftBarButton(done, animated: false)
        
        //        let startAction: ReactiveSwift.Action <Void, Void, NoError> = ReactiveSwift.Action() { [weak self] in
        //            return SignalProducer<Void, NoError> { observer, _ in self?.startButtonTapped(); observer.sendCompleted() }
        //        }
//        let start = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: nil)
//        // start.reactive.pressed = CocoaAction(startAction)
//        navigationItem.setRightBarButton(start, animated: false)
    }
}
// MARK: - UITableViewDataSource
extension GameHistoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.gamesHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameHistoryTableViewCell", for: indexPath) as! GameHistoryTableViewCell
        //   cell.configureCell(collectionOfCell[indexPath.row], String(indexPath.row + 1))
        cell.dateLabel.text = viewModel.gamesHistory[indexPath.row].date.description
        cell.countOfPlayerLabel.text = "\(viewModel.gamesHistory[indexPath.row].countOfPlayers) Players"
        return cell
    }
}
extension GameHistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let currentGame = viewModel.gamesHistory[index]
        print(currentGame.id)
        viewModel.selectGameHistory(currentLocation: currentGame)
        
        
    }
    //    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
    //        if let cell = cell as? NamesOfPlayersTableViewCell{
    //            cell.output.take(until: cell.reactive.prepareForReuse).observeValues { [weak self] value in
    //                switch value {
    //                case .cellDidEndEditing(let cell):
    //                    self?.saveTextOfCellToCollection(cell)
    //                }
    //            }
    //        }
}
