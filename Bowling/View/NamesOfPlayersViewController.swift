//
//  NamesOfPlayersViewController.swift
//  Bowling
//
//  Created by Ihar_Karalko on 18.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit

class NamesOfPlayersViewController: UIViewController//, UITableViewDelegate, UITableViewDataSource {
{
  // @IBOutlet weak var namesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let nib = UINib.init(nibName: "NamesOfPlayersTableViewCell", bundle: nil)
//        self.namesTableView.register(nib, forCellReuseIdentifier: "NamesOfPlayersTableViewCell")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


//// MARK: - UITableView delegate
//func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return 1
//}
//
////func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
////    return 100
////}
//
//func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//    let cell = tableView.dequeueReusableCell(withIdentifier: "NamesOfPlayersTableViewCell", for: indexPath) as! NamesOfPlayersTableViewCell
//
////    //let dict = usersArray[indexPath.row]
////
////    cell.lblFirstName.text = dict["first_name"]
////    cell.lblLastName.text = dict["last_name"]
////
//    return cell
//}
}

