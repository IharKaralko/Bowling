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
    private var cache: NSCache<NSString, UIImage>
    
    init(){
        self.cache = NSCache<NSString, UIImage>()
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
            return  SignalProducer { observer, _ in
                self?.dataSourceOfLocation.deleteAllCDLocations()
                self?._pipe.input.sendCompleted()
                observer.sendCompleted()
            }
        }
    }
}
private extension LocationsViewModel {
    func makeSnapShot(location: Location, imageRect: CGRect) ->  SignalProducer <UIImage?, NoError> {
        
        return SignalProducer<UIImage?, NoError> {[weak self] observer, _ in
            if let image = self?.cache.object(forKey: location.id as NSString) {
                observer.send(value: image)
                observer.sendCompleted()
                return
            }
            
            let mapSnapshotOptions = MKMapSnapshotOptions()
            guard let locationCoordinate = location.coordinate else {
                observer.send(value: nil)
                observer.sendCompleted()
                return
            }
            
            let region = MKCoordinateRegionMakeWithDistance(locationCoordinate, 15000, 15000)
            mapSnapshotOptions.region = region
            mapSnapshotOptions.scale = UIScreen.main.scale
            mapSnapshotOptions.size = CGSize(width: 500, height: 100)
            mapSnapshotOptions.showsBuildings = true
            mapSnapshotOptions.showsPointsOfInterest = true
            let snapshot = MKMapSnapshotter(options: mapSnapshotOptions)
            
            snapshot.start {[weak self]  (snapshot, error) in
                guard let snapshot = snapshot,  error == nil else {
                    print("error")
                    observer.send(value: nil)
                    observer.sendCompleted()
                    return
                }
                
                UIGraphicsBeginImageContextWithOptions(mapSnapshotOptions.size, true, 0)
                defer {  UIGraphicsEndImageContext() }
                
                snapshot.image.draw(at: .zero)
                let pinView = MKPinAnnotationView(annotation: nil, reuseIdentifier: nil)
                let pinImage = pinView.image
                var point = snapshot.point(for: locationCoordinate)
                if imageRect.contains(point) {
                    let pinCenterOffset = pinView.centerOffset
                    point.x -= pinView.bounds.size.width / 2
                    point.y -= pinView.bounds.size.height / 2
                    point.x += pinCenterOffset.x
                    point.y += pinCenterOffset.y
                    pinImage?.draw(at: point)
                }
                guard  let image = UIGraphicsGetImageFromCurrentImageContext() else {
                    observer.send(value: nil)
                    observer.sendCompleted()
                    return
                }
                self?.cache.setObject(image, forKey: location.id as NSString)
                observer.send(value: image)
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
    func mapSnapshotForLocation(location: Location, imageRect: CGRect) -> SignalProducer<UIImage?, NoError> {
     return  makeSnapShot(location:location, imageRect:imageRect) }
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
