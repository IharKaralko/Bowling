//
//  NamesOfPlayersViewController.swift
//  Bowling
//
//  Created by Ihar_Karalko on 18.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit

class NamesOfPlayersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NamesOfPlayersTableViewCellDelegate {
    
    
    
    let countPlayers = 3
    var values: [String] = []
    @IBAction func submit(_ sender: UIButton) {
       
       //self.resignFirstResponder()
        view.endEditing(true)
        
        if collectionOfCell.count == countPlayers{
            print("Ok")
        }  else {
            print("False")
            return }
        
        
    }
    
    
    
    
    var collectionOfCell = [String: String]()
    var names: [String] = []
    
    @IBOutlet weak var bootomConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib.init(nibName: "NamesOfPlayersTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "Cell")
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillHide, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        self.hideKeyboard()
    }


    func saveTextField(_ nuberString: String, _ namePlayer: String){
        
        collectionOfCell[nuberString] = namePlayer
        
    }
    
    

    
    @objc func adjustForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        let bottomTableViewHeight = view.frame.size.height - tableView.frame.maxY
        
        if notification.name == Notification.Name.UIKeyboardWillHide {
            tableView.contentInset = UIEdgeInsets.zero
        } else {
            //      tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height -  bottomTableViewHeight, right: 0)
            tableView.contentInset.bottom = keyboardViewEndFrame.height -  bottomTableViewHeight
        }
        tableView.scrollIndicatorInsets = tableView.contentInset
    }


//// MARK: - UITableView delegate
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return countPlayers
}



    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NamesOfPlayersTableViewCell
        cell.delegate = self
        cell.labelPlayer.text = String(indexPath.row + 1)
        
        return cell
    }
}
     
extension NamesOfPlayersViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(NamesOfPlayersViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
