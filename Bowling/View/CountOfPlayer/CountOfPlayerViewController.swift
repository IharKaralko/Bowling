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
   
    @IBOutlet weak var inputButton: UIButton!
      var viewModel: CountOfPlayer! {
        didSet {
            //bindViewModel()
            bindViewModelOne()
        }
    }
   @IBOutlet weak var textFieldName: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
//       let signal = textFieldName.reactive.continuousTextValues
//
//        signal.observeValues{next in
//            if let nnn = next?.isNumeric  {
//                print(nnn)
//            } else {
//                print("false")
//            }
//
//        }
        bindViewModelOne()
       
    }
}

private extension CountOfPlayerViewController {
    func bindViewModel() {
        guard isViewLoaded else { return }
    //   textFieldName.text = String(viewModel.numbersOfPlayer)
     //   print(textFieldName.text)
        
    }
    
    func bindViewModelOne() {
        guard isViewLoaded else { return }
        
        textFieldName.reactive.text <~ viewModel.inputText
        viewModel.inputText <~ textFieldName.reactive.continuousTextValues
        
        self.inputButton.reactive.pressed = CocoaAction(self.viewModel.inputNumbersOfPlayers)
        { [weak self] (button) -> String?  in
            self?.startButtonTapped()
            return self?.textFieldName.text
            
        }
      // signal = self?.textFieldName.reactive.text
            
           // signal?.observeValues{next in
                
//                if let nnn = signal.value
//
//                    next?.isNumeric, Int(next!)! > 0  {
//                    print(nnn)
//                } else {
//                    print("false")
//                    self?.alertIncorrectCounterOfPlayer()
//
//                }
//
//            }
//
        //   return self?.textFieldName.text
       // }
    }
    
    
    func startButtonTapped() {
        if let numberString = Int(textFieldName.text!), numberString > 1 {
            //print(numberString)
            // viewModel.acceptCountOfPlayers(count: numberString)
            textFieldName.resignFirstResponder()
        } else {
            alertIncorrectCounterOfPlayer()
        }
    }
    
    func alertIncorrectCounterOfPlayer() {
        let alertController = UIAlertController(title: "Attention", message: "Incorrect counter of player?", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
      //  textFieldName.text = nil
    }
}
//    extension String {
//        var isNumeric: Bool {
//            guard self.characters.count > 0 else { return false }
//            let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
//            return Set(self.characters).isSubset(of: nums)
//        }
//}

