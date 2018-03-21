//
//  LocationsViewModel .swift
//  Bowling
//
//  Created by Ihar_Karalko on 13.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation
import MapKit
import ReactiveCocoa
import ReactiveSwift
import Result

class LocationsViewModel {
    
    deinit {
        print("\(type(of: self)).\(#function)")
    }
    
    private var _pipe = Signal<LocationsCoordinator.Action, NoError>.pipe()
    private let locations: [Location]
    private var clearHistoryAction: Action<Void, Void, NoError>!
    private var doneBackAction: Action<Void, Void, NoError>!
    private let dataSourceOfLocation: DataSourceOfLocationProtocol!
    var cache: NSCache<AnyObject, AnyObject>
    
    init(){
        cache = NSCache<AnyObject, AnyObject>()
        cache.countLimit = 20
        dataSourceOfLocation = DataSourceOfLocation()
        self.locations = dataSourceOfLocation.getAllLocations()
        
        self.doneBackAction = Action() { [weak self]  in
            return SignalProducer { observer, _ in
                self?._pipe.input.sendCompleted()
                observer.sendCompleted()
            }
        }
        
        self.clearHistoryAction = Action() { [weak self]  in
            return SignalProducer { observer, _ in
                self?.dataSourceOfLocation.deleteAllCDLocations()
                self?._pipe.input.sendCompleted()
                observer.sendCompleted()
            }
        }
    }
}

private extension LocationsViewModel {
    func locationDidSelect(_ currentLocation: Location) {
        _pipe.input.send(value: LocationsCoordinator.Action.selectLocation(location: currentLocation))
    }
}

extension LocationsViewModel: LocationsViewModelProtocol {
     
    
   // var cacheOne:  NSCache<AnyObject, AnyObject> { return cache }
    var backCancelAction: Action< Void, Void, NoError>  { return doneBackAction }
    var locationsGame: [Location]{ return locations }
    var clearAction: Action<Void, Void, NoError> { return clearHistoryAction }
    func selectLocation(_ currentLocation: Location) {
        locationDidSelect(currentLocation)
    }
}

// MARK: - LocationGameViewModelOutputProtocol
extension LocationsViewModel: LocationsViewModelOutputProtocol {
    var output: Signal<LocationsCoordinator.Action, NoError> { return _pipe.output }
}
