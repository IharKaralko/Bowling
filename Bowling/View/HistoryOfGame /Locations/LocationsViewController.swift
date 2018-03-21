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
    
    @IBOutlet weak var tableView: UITableView!
     var cache = NSCache<AnyObject, AnyObject>()
    
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
        guard let latitude = Double(location.latitude), let longitude = Double(location.longitude) else { print("error"); return cell }
        
        cell.fillLocationLabel(adressLocation: location.adress)
        
        if let image = viewModel.cache.object(forKey: indexPath.row as AnyObject) as? UIImage {
              cell.fillSnapShot(snapShot: image)
        } else {
            cell.makeSnapShot(latitude: latitude, longitude: longitude, cache: viewModel.cache, key: indexPath.row)
          }
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
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        if let cell = cell as? LocationTableViewCell{
            cell.output.take(until: cell.reactive.prepareForReuse).observeValues { [weak self] value in
                switch value {
                case .saveImageToCache(let image, let key):
                    self?.saveCache(image: image, key: key)
                }
            }
        }
}
}
extension LocationsViewController {
    func saveCache(image: UIImage, key: Int){
        viewModel.cache.setObject(image, forKey: key as AnyObject)
        
    }
}
extension  LocationsViewController {
    enum Action {
        case saveImageToCache(image: UIImage, key: Int)
    }
}
