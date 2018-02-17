//
//  DetailsViewController.swift
//  Yelp
//
//  Created by Hye Lim Joun on 2/17/18.
//  Copyright © 2018 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController {
  var business : Business!
  
  @IBOutlet weak var mapView: MKMapView!
  
  @IBOutlet weak var thumbImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var reviewsCountLabel: UILabel!
  @IBOutlet weak var categoriesLabel: UILabel!
  @IBOutlet weak var ratingImageView: UIImageView!
  @IBOutlet weak var distanceLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    nameLabel.text = business.name
    thumbImageView.setImageWith(business.imageURL!)
    categoriesLabel.text = business.categories
    reviewsCountLabel.text = "\(business.reviewCount!) Reviews"
    ratingImageView.setImageWith(business.ratingImageURL!)
    distanceLabel.text = business.distance
    
    let geocoder = CLGeocoder()
    geocoder.geocodeAddressString(business.address!) { [weak self] placemarks, error in
      if let placemark = placemarks?.first, let location = placemark.location {
        let mark = MKPlacemark(placemark: placemark)
        
        if var region = self?.mapView.region {
          region.center = location.coordinate
          region.span.longitudeDelta /= 1500.0
          region.span.latitudeDelta /= 1500.0
          self?.mapView.setRegion(region, animated: true)
          self?.mapView.addAnnotation(mark)
        }
      }
    }
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
