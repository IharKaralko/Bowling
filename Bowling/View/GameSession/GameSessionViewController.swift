//
//  GameSessionViewController.swift
//  Bowling
//
//  Created by Ihar_Karalko on 31.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit

class GameSessionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let game = GameView()
        view.addSubview(game)
        game.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            game.topAnchor.constraint(equalTo:  view.topAnchor, constant: 50),
            game.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            game.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        
        

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

}
