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
     private var _pipe = Signal<LocationsCoordinator.Action, NoError>.pipe()
    var locations: [Location]
     var clearHistoryAction: Action<Void, Void, NoError>!
    
    init(){
        let serviceLocation = ServiceLocation()
        self.locations = serviceLocation.getAll()
        
        self.clearHistoryAction = Action() { [weak self]  in
            return SignalProducer { observer, _ in
                let serviceLocation = ServiceLocation()
                serviceLocation.deleteAll()
                self?._pipe.input.send(value: LocationsCoordinator.Action.clearHistory)
                observer.sendCompleted()
            }
        }
        
    }
}
extension LocationsViewModel{
    func locationDidSelect(currentLocation: Location){
        _pipe.input.send(value: LocationsCoordinator.Action.selectLocation(location: currentLocation))
    }
   
}



// MARK: - LocationGameViewModelOutputProtocol
extension LocationsViewModel: LocationsViewModelOutputProtocol {
    var output: Signal<LocationsCoordinator.Action, NoError> { return _pipe.output }
}
