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
    
    var calloutViewModel: CalloutViewModelOutputProtocol! // = CalloutViewModel()
    var coordinateLocation: CLLocationCoordinate2D? = nil
    private var _pipe = Signal<LocationGameCoordinator.Action, NoError>.pipe()
    private var doneBackAction: Action<Void, Void, NoError>!
    
//    init(calloutViewModel: CalloutViewModel){
//        self.calloutViewModel = calloutViewModel
//        calloutViewModel.output.observeCompleted {
//            print("This")
//        }
//    }
    
    //    private let namesOfPlayer: [String]
//    
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
        func locationGameDidSelect(){
    
            guard let coordinateLocation = coordinateLocation else { return }
            _pipe.input.send(value: .selectLocationOfGame(location: coordinateLocation))
            print(coordinateLocation)
        }
}
    extension LocationGameViewModel: LocationGameViewModelProtocol {
        
        func getAdressLocation(location: CLLocation, completion: @escaping (AdressLocation) -> ()){
            return fetchAdressLocation(location: location, completion: completion)
        }
        
         var backCancelAction: Action< Void, Void, NoError>  { return doneBackAction }
        
}

//    func locationGameDidSelect(input: String){
//
//        _pipe.input.send(value: .locationGameDidSelect(location: input))
//
//    }


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

