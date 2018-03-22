//
//  LocationTableViewCell.swift
//  Bowling
//
//  Created by Ihar_Karalko on 13.03.2018.
//  Copyright © 2018 Ihar_Karalko. All rights reserved.
//

import UIKit
import MapKit
import ReactiveSwift
import Result
import ReactiveCocoa

class LocationTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var imageMap: UIImageView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    var applySnapshot: Action<UIImage?, Void, NoError>!
    var imageRect: CGRect { return imageMap?.bounds ?? .zero }
 
    override func awakeFromNib() {
        super.awakeFromNib()
       setupLayout()
       
        applySnapshot = Action(execute: { [weak self] (image) in
            return SignalProducer { (observer, lifetime) in
                guard !lifetime.hasEnded else { observer.sendCompleted(); return }
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true
                self?.imageMap.image = image
                 observer.sendCompleted()
            }
        })
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageMap.image = nil
    }    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
extension LocationTableViewCell {
  private  func setupLayout() {
        layer.borderWidth = 1.5
        locationLabel.layer.borderWidth = 0.5
    }
    
    func startAcitivityIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func fillLocationLabel(adressLocation: String) {
        locationLabel.text = adressLocation
    }
}
