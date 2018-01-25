//
//  CountOfPlayerViewController.swift
//  Bowling
//
//  Created by Ihar_Karalko on 17.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit

class CountOfPlayerViewController: UIViewController {
    
    var viewModel: CountOfPlayer! {
        didSet { bindViewModel() }
    }
    
    @IBOutlet weak var textFieldName: UITextField!
    @IBAction func buttonClick(_ sender: UIButton) {
        startButtonTapped()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
}

private extension CountOfPlayerViewController {
    func bindViewModel() {
        guard isViewLoaded else { return }
        textFieldName.text = String(viewModel.numbersOfPlayer)
    }
    
    func startButtonTapped() {
        if let numberString = Int(textFieldName.text!) {
            if numberString > 0 {
                viewModel.acceptCountOfPlayers(count: numberString)
                textFieldName.resignFirstResponder()
            } else {
                alertIncorrectCounterOfPlayer()
            }
        } else {
            alertIncorrectCounterOfPlayer()
        }
    }
    
    func alertIncorrectCounterOfPlayer() {
        let alertController = UIAlertController(title: "Attention", message: "Incorrect counter of player?", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
        textFieldName.text = nil
    }
}
