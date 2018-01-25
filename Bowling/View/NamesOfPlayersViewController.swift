//
//  NamesOfPlayersViewController.swift
//  Bowling
//
//  Created by Ihar_Karalko on 18.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit

class NamesOfPlayersViewController: UIViewController {
    
    var countPlayers = 3
    var collectionOfCell = [Int: String]()
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: NamesOfPlayers! {
        didSet { bindViewModel() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        let nib = UINib.init(nibName: "NamesOfPlayersTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "NamesOfPlayersTableViewCell")
        self.hideKeyboard()
        let done = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(doneBack))
        navigationItem.setLeftBarButton(done, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillHide, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func submit(_ sender: UIButton) {
        startButtonTapped()
    }
}

// MARK: - NamesOfPlayersTableViewCellDelegate
extension NamesOfPlayersViewController: NamesOfPlayersTableViewCellDelegate {
    func saveTextField(_ cell: NamesOfPlayersTableViewCell) {
        if let IndexPath = tableView.indexPath(for: cell) {
            if cell.textFieldIsFull() {
                collectionOfCell[IndexPath.row] = cell.textCell()
            } else {
                collectionOfCell[IndexPath.row] = nil
            }
        }
    }
}

// MARK: - Private methods
private extension NamesOfPlayersViewController {
    func bindViewModel() {
        guard isViewLoaded else { return }
    }
    
    func startButtonTapped() {
        view.endEditing(true)
        if collectionOfCell.count == countPlayers {
            print("Ok")
            let listNames = [String](collectionOfCell.values)
            viewModel.acceptNamesOfPlayers(collectionOfNames: listNames)
        }  else {
            print("False")
        }
    }
    
    @objc
    func doneBack(){
        viewModel.doneBack()
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
            action: #selector(NamesOfPlayersViewController.dismissKeyboard))
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
        return countPlayers
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NamesOfPlayersTableViewCell", for: indexPath) as! NamesOfPlayersTableViewCell
        cell.delegate = self
        cell.numberOfPlayer(numberString: String(indexPath.row + 1))
        return cell
    }
}
