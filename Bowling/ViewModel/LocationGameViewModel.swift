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
    
    deinit {
        print("\(type(of: self)).\(#function)")
    }
    
  //  var calloutViewModel: CalloutViewModelOutputProtocol!
    var coordinateLocation: CLLocationCoordinate2D?
    private var _pipe = Signal<LocationGameCoordinator.Action, NoError>.pipe()
    private var doneBackAction: Action<Void, Void, NoError>!
    
    init (){
        self.doneBackAction = Action() { [weak self]  in
            return SignalProducer { observer, _ in
                self?._pipe.input.sendCompleted()
                observer.sendCompleted()
            }
        }
       }
    
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
    func locationGameDidSelect() {
             guard let coordinateLocation = coordinateLocation else { return }
            _pipe.input.send(value: .selectLocationOfGame(location: coordinateLocation))
            print(coordinateLocation)
        }
}
extension LocationGameViewModel: LocationGameViewModelProtocol {
       
    func selectLocation() {  return locationGameDidSelect() }
  //  var callout: CalloutViewModelOutputProtocol { return calloutViewModel }
    var backCancelAction: Action< Void, Void, NoError>  { return doneBackAction }
    func getAdressLocation(location: CLLocation, completion: @escaping (AdressLocation) -> ()) {
        return fetchAdressLocation(location: location, completion: completion)
    }
}

struct AdressLocation {
    var country: String!
    var city: String!
    var name: String!
    var adress: String { return country + " " +  city + " " + name }
}

// MARK: - LocationGameViewModelOutputProtocol
extension LocationGameViewModel: LocationGameViewModelOutputProtocol {
  var output: Signal<LocationGameCoordinator.Action, NoError> { return _pipe.output }
}

