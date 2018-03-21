//
//  LocationTableViewCell.swift
//  Bowling
//
//  Created by Ihar_Karalko on 13.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit
import MapKit

class LocationTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var imageMap: UIImageView!
  
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       setupLayout()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
extension LocationTableViewCell {
    func setupLayout() {
        layer.borderWidth = 1.5
      locationLabel.layer.borderWidth = 0.5

        
    }
    func fillLocationLabel(adressLocation: String){
        locationLabel.text = adressLocation //latitude: \(latitude) longitude: \(longitude)"
    }
    func fillSnapShot(snapShot: UIImage){
        imageMap.image = snapShot
    }
   // cache: NSCache<AnyObject, AnyObject>,
    
    func makeSnapShot(latitude: Double, longitude: Double,  key: Int) {
        
        let indicator = UIActivityIndicatorView(frame: CGRect(x: self.imageMap.bounds.width/2 - 15, y: self.imageMap.bounds.height/2 - 15, width: 30, height: 30))
        addSubview(indicator)
        indicator.color = UIColor.black
        indicator.startAnimating()
        
        let mapSnapshotOptions = MKMapSnapshotOptions()
        
        // Set the region of the map that is rendered.
        let location = CLLocationCoordinate2DMake(latitude, longitude) // Apple HQ
        let region = MKCoordinateRegionMakeWithDistance(location, 15000, 15000)
        mapSnapshotOptions.region = region
        
        // Set the scale of the image. We'll just use the scale of the current device, which is 2x scale on Retina screens.
        mapSnapshotOptions.scale = UIScreen.main.scale
       
        // Set the size of the image output.
        mapSnapshotOptions.size = CGSize(width: 500, height: 100)
        
        // Show buildings and Points of Interest on the snapshot
        mapSnapshotOptions.showsBuildings = true
        mapSnapshotOptions.showsPointsOfInterest = true
        
        
        let snapshot = MKMapSnapshotter(options: mapSnapshotOptions)
        
        snapshot.start {[weak self]  (snapshot, error) in
            guard let snapshot = snapshot,  error == nil else {
                print("error")
                return
            }
            
           // let cacheOne = cache
            //self.imageView.image = snapshot?.image
            
           guard let rect = self?.imageMap.bounds else { return }
            
            
            
            UIGraphicsBeginImageContextWithOptions(mapSnapshotOptions.size, true, 0)
            snapshot.image.draw(at: .zero)
            
            let pinView = MKPinAnnotationView(annotation: nil, reuseIdentifier: nil)
            let pinImage = pinView.image
           
            // let pinImage =  #imageLiteral(resourceName: "bowling ")
            
            var point = snapshot.point(for: location)
            
            if rect.contains(point) {
                let pinCenterOffset = pinView.centerOffset
                point.x -= pinView.bounds.size.width / 2
                point.y -= pinView.bounds.size.height / 2
                point.x += pinCenterOffset.x
                point.y += pinCenterOffset.y
                pinImage?.draw(at: point)
            }
            
            guard  let image = UIGraphicsGetImageFromCurrentImageContext() else { return }
           
            //cache.setObject(image, forKey: key as AnyObject)
            
            UIGraphicsEndImageContext()
            
            // do whatever you want with this image, e.g.
            
              DispatchQueue.main.async {
                 indicator.stopAnimating()
                self?.imageMap.image = image
                
               // self?.cache.setObject(image, forKey: key as AnyObject)
                
            }
        }
        
    }
}
