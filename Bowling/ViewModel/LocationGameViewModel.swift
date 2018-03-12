//
//  LocationGameViewModel.swift
//  Bowling
//
//  Created by Ihar_Karalko on 02.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import Foundation
import MapKit
import ReactiveCocoa
import ReactiveSwift
import Result

class LocationGameViewModel {
    
//    var calloutViewModel: CalloutViewModel // = CalloutViewModel()
//    var coordinateLocation: CLLocationCoordinate2D? = nil
    
    
    
//    init(calloutViewModel: CalloutViewModel){
//        self.calloutViewModel = calloutViewModel
//        calloutViewModel.output.observeCompleted {
//            print("This")
//        }
//    }
    
    //    private let namesOfPlayer: [String]
//    
//    init (namesOfPlayer: [String]){
//        self.namesOfPlayer  = namesOfPlayer
//    }
  private var _pipe = Signal<LocationGameCoordinator.Action, NoError>.pipe()
        
    func fetchAdressLocation(location: CLLocation, completion: @escaping (AdressLocation) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            var adressLocation = AdressLocation()
            if let error = error {
                print(error)
            } else if let  country = placemarks?.first?.country,
                let city = placemarks?.first?.locality,
                let name = placemarks?.first?.name
            {
                adressLocation.country = country
                adressLocation.city = city
                adressLocation.name = name
                completion(adressLocation)
            }
        }
    }
    
//    func locationGameDidSelect(input: String){
//
//        _pipe.input.send(value: .locationGameDidSelect(location: input))
//
//    }
}

struct AdressLocation {
    var country: String!
    var city: String!
    var name: String!
    var adress: String { return country + " " +  city + " " + name }
}

// MARK: - LocationGameViewModelOutputProtocol
//extension LocationGameViewModel: LocationGameViewModelOutputProtocol {
// //   var output: Signal<GameSessionViewModel.Action, NoError> { return _pipe.output }
//}

