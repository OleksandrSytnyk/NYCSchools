//
//  SchoolTableViewCellViewModel.swift
//  20190603-OleksandrSytnyk-NYCSchools
//
//  Created by Oleksandr Sytnyk on 6/3/19.
//  Copyright © 2019 Oleksandr Sytnyk. All rights reserved.
//

import Foundation

protocol SchoolTableViewCellPresentable {
  var dbn: String { get }
  var name: String { get }
  var address: String { get }
  var studentsNumber: String { get }
}

struct SchoolTableViewCellViewModel {
  var school: School
  
  init(school: School) {
    self.school = school
  }
}

extension SchoolTableViewCellViewModel: SchoolTableViewCellPresentable {
  
  var dbn: String {
    return school.dbn
  }
  
  var name: String {
    return school.name.capitalized
  }
  
  var address: String {
    return school.address
  }
 
  var studentsNumber: String {
    return school.studentsNumber
  }
}
