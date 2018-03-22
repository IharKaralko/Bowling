//
//  LocationsViewController.swift
//  Bowling
//
//  Created by Ihar_Karalko on 13.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import ReactiveSwift
import Result
import ReactiveCocoa

class LocationsViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    deinit {
        print("\(type(of: self)).\(#function)")
    }
    var viewModel: LocationsViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        setupBarButton()       
    }
}

// MARK: - Private methods
private extension LocationsViewController {
    func commonInit() {
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib.init(nibName: "LocationTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "LocationTableViewCell")
    }
    
    func setupBarButton(){
        self.navigationItem.title = "HISTORY"
        let done = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        done.reactive.pressed = CocoaAction(viewModel.backCancelAction)
        navigationItem.setLeftBarButton(done, animated: false)
        
        let clear = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: nil)
        clear.reactive.pressed = CocoaAction(viewModel.clearAction)
        navigationItem.setRightBarButton(clear, animated: false)
    }
}

// MARK: - UITableViewDataSource
extension LocationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.locationsGame.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell", for: indexPath) as! LocationTableViewCell
        let location = viewModel.locationsGame[indexPath.row]
        cell.fillLocationLabel(adressLocation: location.adress)
        return cell
    }
}

extension LocationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let currentLocation = viewModel.locationsGame[index]
        viewModel.selectLocation(currentLocation)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
   
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let locationCell = cell as? LocationTableViewCell else { return }
        let location = viewModel.locationsGame[indexPath.row]
        locationCell.startAcitivityIndicator()
        locationCell.applySnapshot.bindingTarget <~ viewModel.mapSnapshotForLocation(location: location,
                                                                                     imageRect: locationCell.imageRect)
            .take(until: locationCell.reactive.prepareForReuse)
    }
}


