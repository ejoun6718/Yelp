//
//  MapViewController.swift
//  Yelp
//
//  Created by Hye Lim Joun on 2/17/18.
//  Copyright © 2018 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
  
  @IBOutlet weak var mapView: MKMapView!
  var address = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let geocoder = CLGeocoder()
    geocoder.geocodeAddressString(address) { [weak self] placemarks, error in
      if let placemark = placemarks?.first, let location = placemark.location {
        let mark = MKPlacemark(placemark: placemark)
        
        if var region = self?.mapView.region {
          region.center = location.coordinate
          region.span.longitudeDelta /= 1000.0
          region.span.latitudeDelta /= 1000.0
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
