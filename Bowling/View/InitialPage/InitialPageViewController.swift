//
//  InitialPageViewController.swift
//  Bowling
//
//  Created by Ihar_Karalko on 07.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//
import UIKit
import ReactiveSwift
import Result
import ReactiveCocoa

class InitialPageViewController: UIViewController {

    @IBOutlet weak var startNewGameButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    
    var viewModel: InitialPageViewModelProtocol! {
        didSet {
            bindViewModel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
}

private extension InitialPageViewController {
    func bindViewModel() {
        guard isViewLoaded else { return }
      
        startNewGameButton.reactive.pressed = CocoaAction(viewModel.beginNewGameAction)
        historyButton.reactive.pressed = CocoaAction(viewModel.goToHistoryAction)
    }
    
}
