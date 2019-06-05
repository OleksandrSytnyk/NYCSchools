//
//  Location.swift
//  20190603-OleksandrSytnyk-NYCSchools
//
//  Created by Oleksandr Sytnyk on 2/10/19.
//  Copyright © 2019 Oleksandr Sytnyk. All rights reserved.
//

import MapKit

class SchoolLocation: NSObject, MKAnnotation {
  
  var school: School
  var longitude: Double
  var latitude: Double
  
  init(school: School, longitude: Double, latitude: Double) {
    self.school = school
    self.longitude = longitude
    self.latitude = latitude
  }
  
  var title: String? {
    return school.name
  }
  
  var subtitle: String? {
    return school.address
  }
  
  var coordinate: CLLocationCoordinate2D {
    return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
  }
}
