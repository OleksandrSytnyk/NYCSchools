//
//  MapViewController.swift
//  20190603-OleksandrSytnyk-NYCSchools
//
//  Created by Oleksandr Sytnyk on 2/10/19.
//  Copyright © 2019 Oleksandr Sytnyk. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
  
  @IBOutlet weak var mapView: MKMapView!
  
  var locationManager = CLLocationManager()
  var schools = [School]()
  var selectedSchoolIndex = 0
  var tappedPinHandler: ((Int) -> Void)?
  var schoolDetailsHandler: ((String) -> Void)?
  
  var currentCenter: SchoolLocation? {
    guard !schools.isEmpty else {
      return nil
    }
    
    let selectedSchool = schools[selectedSchoolIndex]
    guard !((selectedSchool.longitude == 0.0) && (selectedSchool.longitude == 0.0)) else {
      return nil
    }
    let location = SchoolLocation(school: selectedSchool, longitude: selectedSchool.longitude, latitude: selectedSchool.latitude)
    
    return location
  }
  
  var locations: [SchoolLocation] {
    var result = [SchoolLocation]()
    
    for school in schools {
      guard !((school.longitude == 0.0) && (school.longitude == 0.0)) else {
        break
      }
      result.append(SchoolLocation(school: school, longitude: school.longitude, latitude: school.latitude))
    }
    return result
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    mapView.delegate = self
    
    locationManager.requestWhenInUseAuthorization()
    locationManager.delegate = self
    mapView.showsUserLocation = true
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    DispatchQueue.main.async {
      self.locationManager.startUpdatingLocation()
    }
  }
  
  func setRegion() {
    mapView.addAnnotations(locations)
    guard let currentCenter = currentCenter else { return }
    let region = MKCoordinateRegion(center: currentCenter.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
    mapView.setRegion(region, animated: true)
  }
  
  func createPinView(annotation: MKAnnotation, identifier: String) -> MKPinAnnotationView {
    // OS: TODO - create a custom class and move annotation setup there
    let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
    pinView.pinTintColor = .green
    pinView.tintColor = .black
    pinView.isEnabled = true
    pinView.canShowCallout = true
    
    let rightButton = UIButton(type: UIButton.ButtonType.detailDisclosure)
    if let index = identifyAnnotation(annotation: annotation) {
      rightButton.tag = index
    }
    
    rightButton.addTarget(self, action: #selector(showInfo(sender:)), for: UIControl.Event.touchUpInside)
    pinView.rightCalloutAccessoryView = rightButton
    return pinView
  }
  
  func identifyAnnotation(annotation: MKAnnotation) -> Int? {
    for index in 0...schools.count - 1 {
      if (annotation as? SchoolLocation)?.coordinate == CLLocationCoordinate2D(latitude: schools[index].latitude, longitude: schools[index].longitude) {
        return index
      }
    }
    return nil
  }
  
  @objc func showInfo(sender: UIButton?) {
    guard let index = sender?.tag, index < schools.count - 1, index >= 0 else { return }
    tappedPinHandler?(index)
  }
}

extension MapViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    let identifier = "identifier"
    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
    
    if annotationView == nil {
      annotationView = createPinView(annotation: annotation, identifier: identifier)
    }
    
    if let annotationViewWithRightColor = annotationView as? MKPinAnnotationView, let coordinate = currentCenter?.coordinate {
      
      if annotation.coordinate == coordinate {
        annotationViewWithRightColor.pinTintColor = .red
      } else {
        annotationViewWithRightColor.pinTintColor = .green
      }
      
      annotationView = annotationViewWithRightColor
    }
    annotationView?.annotation = annotation
    return annotationView
  }
}

extension MapViewController: CLLocationManagerDelegate {
  //OS: TODO - finish up geolocation
  func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
    let location = locations.last as! CLLocation
    let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    var region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    region.center = mapView.userLocation.coordinate
    mapView.setRegion(region, animated: true)
  }
}

extension CLLocationCoordinate2D: Equatable {
  
  static public func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
    return (lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude)
  }
}
