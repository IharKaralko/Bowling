//
//  LocationsViewController.swift
//  Bowling
//
//  Created by Ihar_Karalko on 13.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit
import CoreLocation
import ReactiveSwift
import Result
import ReactiveCocoa

class LocationsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    deinit {
        print("LocationsViewController deinit--------")
    }
    
     var viewModel: LocationsViewModel = LocationsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       bindViewModel()
      commonInit()
        setupBarButton()       
    }


}
// MARK: - Private methods
private extension LocationsViewController {
    func bindViewModel() {
        guard isViewLoaded else { return }
}
    func commonInit() {
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib.init(nibName: "LocationTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "LocationTableViewCell")
       // self.hideKeyboard()
        
    }
    func setupBarButton(){
        self.navigationItem.title = "HISTORY"
        
        let done = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        //done.reactive.pressed = CocoaAction(viewModel.backCancelAction)
        navigationItem.setLeftBarButton(done, animated: false)
        
//        let startAction: ReactiveSwift.Action <Void, Void, NoError> = ReactiveSwift.Action() { [weak self] in
//            return SignalProducer<Void, NoError> { observer, _ in self?.startButtonTapped(); observer.sendCompleted() }
//        }
        let clear = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: nil)
        clear.reactive.pressed = CocoaAction(viewModel.clearHistoryAction)
       // tableView.reloadData()
        navigationItem.setRightBarButton(clear, animated: false)
    }
}
// MARK: - UITableViewDataSource
extension LocationsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.locations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell", for: indexPath) as! LocationTableViewCell
     //   cell.configureCell(collectionOfCell[indexPath.row], String(indexPath.row + 1))
       cell.locationLabel.text = viewModel.locations[indexPath.row].location
        
        return cell
    }
}
extension LocationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let currentLocation = viewModel.locations[index]
        print(currentLocation.id)
        viewModel.locationDidSelect(currentLocation: currentLocation)
        
    }
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
//        if let cell = cell as? NamesOfPlayersTableViewCell{
//            cell.output.take(until: cell.reactive.prepareForReuse).observeValues { [weak self] value in
//                switch value {
//                case .cellDidEndEditing(let cell):
//                    self?.saveTextOfCellToCollection(cell)
//                }
//            }
//        }
}
