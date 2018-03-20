//
//  LocationGameViewController.swift
//  Bowling
//
//  Created by Ihar_Karalko on 01.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import ReactiveSwift
import Result
import ReactiveCocoa

class LocationGameViewController: UIViewController {
    
    deinit {
        print("\(type(of: self)).\(#function)")
    }
   
    var viewModel: LocationGameViewModelProtocol!
    var locationManager: CLLocationManager!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        mapView.userLocation.subtitle = "latitude: 53,711500 longitude: 23,824200"
        setupBarButton()
        setupGestureRecognizer()
        self.mapView.delegate = self
    }
}

private extension LocationGameViewController {
     func setupBarButton(){
        self.navigationItem.title = "Select place of game session"
        let done = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        done.reactive.pressed = CocoaAction(viewModel.backCancelAction)
        navigationItem.setLeftBarButton(done, animated: false)
    }
    
    func setupGestureRecognizer(){
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(gestureAction(press:)))
        longPressGestureRecognizer.minimumPressDuration = 0.4
        mapView.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    @objc
    func gestureAction(press: UILongPressGestureRecognizer) {
        if press.state ==  .began  {
            let allAnnotations = self.mapView.annotations
            self.mapView.removeAnnotations(allAnnotations)
            createAnnotation(press)
        }
    }
    
    func createAnnotation(_ press: UILongPressGestureRecognizer){
        let location = press.location(in: mapView)
        let coordinates = mapView.convert(location, toCoordinateFrom: mapView)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinates
         let userLatitude = String(format: "%f",  coordinates.latitude)
         let userLongitude = String(format: "%f",  coordinates.longitude)
        
        let coordinateLocation = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
        let service = SettingOfAdress()
        service.fetchAdressLocation(location: coordinateLocation) { [weak annotation] adressLocation  in
            if adressLocation.adress.isEmpty {
                annotation?.subtitle = "latitude: \(userLatitude) longitude: \(userLongitude)"
            } else {
                annotation?.subtitle = adressLocation.adress
            }
        }
        mapView.addAnnotation(annotation)
    }
}

extension LocationGameViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "User")
            annotationView = AnnotationView(annotation: annotation, reuseIdentifier: "User")
            annotationView?.canShowCallout = false
            annotationView?.image = #imageLiteral(resourceName: "userPlace")
            return annotationView
        }  else {
            var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
            if annotationView == nil{
                annotationView = AnnotationView(annotation: annotation, reuseIdentifier: "Pin")
                annotationView?.canShowCallout = false
            } else {
                annotationView?.annotation = annotation
            }
            annotationView?.image = #imageLiteral(resourceName: "pin")
            return annotationView
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
        for annot in mapView.annotations {
            if annot !== annotation {
                mapView.removeAnnotation(annot)
            }
        }
        let calloutView = CustomView()
       guard let adress = annotation.subtitle, let adressLocation = adress else{ return }
        
        let configurationGame = ConfigurationGame(location: annotation.coordinate, adressLocation:adressLocation)
        
        
        viewModel.beginGameAction.bindingTarget <~ calloutView.customCalloutView.touchSignal.map{ _ in configurationGame }

        if let subtitle = annotation.subtitle {
        calloutView.customCalloutView.fillAdress(subtitle!)
        }
        calloutView.center = CGPoint(x: view.bounds.size.width / 2, y:  -calloutView.bounds.size.height / 2  )
        view.addSubview(calloutView)
        mapView.setCenter(annotation.coordinate, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        for subview in view.subviews { if subview is CustomView { subview.removeFromSuperview() }
        }
    }
}
