//
//  CountOfPlayerViewController.swift
//  Bowling
//
//  Created by Ihar_Karalko on 17.01.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result
import ReactiveCocoa

class CountOfPlayerViewController: UIViewController {
    
    @IBOutlet private weak var inputButton: UIButton!
    @IBOutlet private weak var textFieldName: UITextField!
    var viewModel: CountOfPlayerProtocol! {
        didSet {
            bindViewModel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
         setupBarButton()
        
    }
}

private extension CountOfPlayerViewController {
    func bindViewModel() {
        guard isViewLoaded else { return }
        textFieldName.text = viewModel.numberOfPlayers.description
        
        let action: Action< Void, Void, NoError> = Action(){ [weak self] _ in
            return  SignalProducer<Void, NoError> { observer, _ in
                self?.startButtonTapped()
                observer.sendCompleted()
            }
        }
        inputButton.reactive.pressed = CocoaAction(action)
    }
    
    func  setupBarButton(){
        
        let done = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        done.reactive.pressed = CocoaAction(viewModel.backCancelAction)
        navigationItem.setLeftBarButton(done, animated: false)
        
    }
    
    func startButtonTapped() {
        if let numberString = textFieldName.text, let number = Int(numberString), number > 0 {
            textFieldName.resignFirstResponder()
            self.viewModel.getNumbersOfPlayersAction.apply(number).start()
        } else {
            alertIncorrectCounterOfPlayer()
        }
    }
    
    func alertIncorrectCounterOfPlayer() {
        let alertController = UIAlertController(title: "Attention", message: "Incorrect counter of player?", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
}


