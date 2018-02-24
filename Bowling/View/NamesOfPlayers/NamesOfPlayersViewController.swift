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
        print("NamesOfPlayersViewController deinit--------")
    }
   
    private let _pipe = Signal<(), NoError>.pipe()
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
        
        let bag = CompositeDisposable()
        let notificationCenter = NotificationCenter.default.reactive
        
        
        bag += notificationCenter.notifications(forName: Notification.Name.UIKeyboardWillHide)
            .observeValues{ [weak self] notification in self?.adjustForKeyboard(notification: notification )}
        
        bag += notificationCenter.notifications(forName: Notification.Name.UIKeyboardWillChangeFrame)
            .observeValues { [weak self] notification in self?.adjustForKeyboard(notification: notification )}
        
        _pipe.output.observeValues({bag.dispose()})
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
       _pipe.input.send(value: ())
       
       
    }
}

// MARK: - Private methods
private extension NamesOfPlayersViewController {
    func bindViewModel() {
        guard isViewLoaded else { return }
    }
    
    func commonInit() {
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib.init(nibName: "NamesOfPlayersTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "NamesOfPlayersTableViewCell")
        self.hideKeyboard()
        
    }
    
    func setupBarButton(){
        self.navigationItem.title = "Names OF PLAYERS"
        
        let done = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        done.reactive.pressed = CocoaAction(viewModel.backCancelAction)
        navigationItem.setLeftBarButton(done, animated: false)
        
        let startAction: ReactiveSwift.Action <Void, Void, NoError> = ReactiveSwift.Action() { [weak self] in
            return SignalProducer<Void, NoError> { observer, _ in self?.startButtonTapped(); observer.sendCompleted() }
        }
        let start = UIBarButtonItem(title: "Start", style: .plain, target: self, action: nil)
        start.reactive.pressed = CocoaAction(startAction)
        navigationItem.setRightBarButton(start, animated: false)
    }
    
    
    func saveTextOfCellToCollection(_ cell: NamesOfPlayersTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            if cell.textFieldIsFull() {
                collectionOfCell[indexPath.row] = cell.returnTextOfCell()
            } else {
                collectionOfCell[indexPath.row] = nil
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
        cell.saveTextOfCell(collectionOfCell[indexPath.row])
        cell.showNumberOfPlayer(String(indexPath.row + 1))
        return cell
    }
}
extension NamesOfPlayersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        if let cell = cell as? NamesOfPlayersTableViewCell{
        cell.output.take(until: cell.reactive.prepareForReuse).observeValues { [weak self] value in
                        switch value {
                        case .cellDidEndEditing(let cell):
                            self?.saveTextOfCellToCollection(cell)
                        }
                    }
             }
    }
}

extension NamesOfPlayersViewController {
    enum Action {
        case cellDidEndEditing(cell: NamesOfPlayersTableViewCell)
    }
}
