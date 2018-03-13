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
