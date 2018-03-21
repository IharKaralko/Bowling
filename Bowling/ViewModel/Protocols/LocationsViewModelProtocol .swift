//
//  LocationsViewModelProtocol .swift
//  Bowling
//
//  Created by Ihar_Karalko on 13.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation
import MapKit
import ReactiveSwift
import Result
import ReactiveCocoa

protocol LocationsViewModelOutputProtocol {
    var output: Signal<LocationsCoordinator.Action, NoError> { get }
}

protocol LocationsViewModelProtocol {
    var backCancelAction: Action< Void, Void, NoError>  { get }
    var locationsGame: [Location]{ get }
    var clearAction: Action<Void, Void, NoError> { get }
    func selectLocation(_ currentLocation: Location)
    var cache:  NSCache<AnyObject, AnyObject> { set get }
    
}
