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

class LocationGameViewController: UIViewController {
    
    var viewModel: LocationGameViewModel = LocationGameViewModel()
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserLocation()
        setupBarButton()
        setupGestureRecognizer()
        self.mapView.delegate = self
     }
}

private extension LocationGameViewController {
    func setupUserLocation(){
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
    }
    
    func setupBarButton(){
        self.navigationItem.title = "Select plase of game session"
        let done = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        //   done.reactive.pressed = CocoaAction(viewModel.backCancelAction)
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
        let coordinateLocation = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
        viewModel.fetchAdressLocation(location:  coordinateLocation)  { [weak annotation] adressLocation  in
            annotation?.subtitle = adressLocation.adress
        }
        mapView.addAnnotation(annotation)
    }
}

extension LocationGameViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "User")
            annotationView.canShowCallout = false
            annotationView.image = #imageLiteral(resourceName: "userPlace")
            return annotationView
        }  else {
            var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
            if annotationView == nil{
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
                annotationView?.canShowCallout = false
            } else {
                annotationView?.annotation = annotation
            }
            annotationView?.image = #imageLiteral(resourceName: "pin")
            return annotationView
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else {return}
        let calloutView = CustomCalloutView()
        let demoView = CalloutLegView()
      
        demoView.center = CGPoint(x: view.bounds.size.width / 2, y: -demoView.bounds.size.height / 2)
        
        view.addSubview(demoView)
        
        if let subtitle = annotation.subtitle {
            calloutView.fillAdress(subtitle)
        }
        calloutView.center = CGPoint(x: view.bounds.size.width / 2, y: -calloutView.bounds.height/2 - demoView.bounds.size.height) 
        view.addSubview(calloutView)
        mapView.setCenter(annotation.coordinate, animated: true)
       }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        for subview in view.subviews { if subview is CustomCalloutView { subview.removeFromSuperview() }
        }
        for subview in view.subviews { if subview is CalloutLegView { subview.removeFromSuperview() }
        }
      }
}
