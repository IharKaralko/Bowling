//
//  PlayersViewController.swift
//  Bowling
//
//  Created by Ihar_Karalko on 13.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit

class PlayersViewController: UIViewController {
   
    @IBOutlet weak var tableView: UITableView!
    
    deinit {
        print("PlayersViewController deinit--------")
    }
    
    var viewModel: PlayersViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        commonInit()
        setupBarButton()
       
    }
   
}
// MARK: - Private methods
private extension PlayersViewController {
    func bindViewModel() {
        guard isViewLoaded else { return }
    }
    func commonInit() {
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib.init(nibName: "PlayersTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "PlayersTableViewCell")
        // self.hideKeyboard()
        
    }
    func setupBarButton(){
        self.navigationItem.title = "PlAYERS RESULT"
        
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
extension PlayersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.playersOfGame.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayersTableViewCell", for: indexPath) as! PlayersTableViewCell
        cell.nameLabel.text = viewModel.playersOfGame[indexPath.row].name
        cell.scoreGame.text = viewModel.playersOfGame[indexPath.row].scoreGame.description
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension PlayersViewController: UITableViewDelegate {

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
