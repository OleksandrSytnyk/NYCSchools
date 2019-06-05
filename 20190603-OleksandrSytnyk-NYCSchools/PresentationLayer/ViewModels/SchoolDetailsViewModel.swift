//
//  SchoolDetailsViewModel.swift
//  20190603-OleksandrSytnyk-NYCSchools
//
//  Created by Oleksandr Sytnyk on 2/10/19.
//  Copyright © 2019 Oleksandr Sytnyk. All rights reserved.
//

import Foundation

protocol SchoolDetailsPresentable {
  var dbn: String { get }
  var name: String { get }
  var satReading: String { get }
  var satMath: String { get }
  var satWriting: String { get }
  var numberOfSATTestTakers: String { get }
}

struct SchoolDetailsViewModel {
  
  var school: School
  
  init(school: School) {
    self.school = school
  }
}

extension SchoolDetailsViewModel: SchoolDetailsPresentable {

  var dbn: String {
    return school.dbn
  }
  
  var name: String {
    return school.name.capitalized
  }
  
  var satReading: String {
    return school.sat.reading
  }
  
  var satMath: String {
    return school.sat.math
  }
  
  var satWriting: String {
    return school.sat.writing
  }
  
  var numberOfSATTestTakers: String {
    return school.sat.numberOfSATTestTakers
  }
}
