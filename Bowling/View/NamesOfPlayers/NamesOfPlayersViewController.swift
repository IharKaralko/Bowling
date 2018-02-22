//
//  NamesOfPlayersViewController.swift
//  Bowling
//
//  Created by Ihar_Karalko on 18.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result
import ReactiveCocoa


class NamesOfPlayersViewController: UIViewController {
    deinit {
        print("GameSessionViewController deinit--------")
    }
    
    
    var collectionOfCell = [Int: String]()
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: NamesOfPlayersProtocol! {
        didSet { bindViewModel() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        commonInit()
        setupBarButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {        
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillHide, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Private methods
private extension NamesOfPlayersViewController {
    func bindViewModel() {
        guard isViewLoaded else { return }
    }
    
    func commonInit() {
        tableView.dataSource = self
        let nib = UINib.init(nibName: "NamesOfPlayersTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "NamesOfPlayersTableViewCell")
        self.hideKeyboard()
        
    }
    
    func setupBarButton(){
        self.navigationItem.title = "Names OF PLAYERS"
        
        let done = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        done.reactive.pressed = CocoaAction(viewModel.backCancelAction)
        navigationItem.setLeftBarButton(done, animated: false)
        
        let startAction: Action<Void, Void, NoError> = Action() { [weak self] in
            return SignalProducer<Void, NoError> { observer, _ in self?.startButtonTapped(); observer.sendCompleted() }
        }
        let start = UIBarButtonItem(title: "Start", style: .plain, target: self, action: nil)
        start.reactive.pressed = CocoaAction(startAction)
        navigationItem.setRightBarButton(start, animated: false)
    }
    
    
    func saveTextOfCell(_ cell: NamesOfPlayersTableViewCell) {
        if let IndexPath = tableView.indexPath(for: cell) {
            if cell.textFieldIsFull() {
                collectionOfCell[IndexPath.row] = cell.textCell()
            } else {
                collectionOfCell[IndexPath.row] = nil
            }
        }
    }
    
    func startButtonTapped() {
        view.endEditing(true)
        if collectionOfCell.count == viewModel.numberOfPlayers {
            let listNames = [String](collectionOfCell.values)
            viewModel.namesOfPlayersAction.apply(listNames).start()
        }  else {
        }
    }
    
    @objc
    func adjustForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        let bottomTableViewHeight = view.frame.size.height - tableView.frame.maxY
        
        if notification.name == Notification.Name.UIKeyboardWillHide {
            tableView.contentInset = UIEdgeInsets.zero
        } else {
            tableView.contentInset.bottom = keyboardViewEndFrame.height -  bottomTableViewHeight
        }
        tableView.scrollIndicatorInsets = tableView.contentInset
    }
    
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer (
            target: self,
            action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UITableViewDataSource
extension NamesOfPlayersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPlayers
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NamesOfPlayersTableViewCell", for: indexPath) as! NamesOfPlayersTableViewCell
       
        cell.output.observeValues { [weak self] value in
            switch value {
            case .cellDidEndEditing(let cell):
                self?.saveTextOfCell(cell)
            }
        }
        cell.numberOfPlayer(numberString: String(indexPath.row + 1))
        return cell
    }
}

extension NamesOfPlayersViewController {
    enum Actions {
        case cellDidEndEditing(cell: NamesOfPlayersTableViewCell)
    }
}
