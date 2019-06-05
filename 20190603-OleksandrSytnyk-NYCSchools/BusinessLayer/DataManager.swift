//
//  DataManager.swift
//  20190603-OleksandrSytnyk-NYCSchools
//
//  Created by Oleksandr Sytnyk on 6/3/19.
//  Copyright © 2019 Oleksandr Sytnyk. All rights reserved.
//

import Foundation

/// Data Manager acts as a layer between UI layer and other layers providing data (e.g. NetworkManager, PersistenceManager, and other service managers)
struct DataManager {
  static let shared = DataManager()
  
  func getSchools(successHandler: @escaping ([School]) -> Void,
                  errorHandler: @escaping (String?) -> Void) {
    NetworkManager.shared.getSchools(successHandler: successHandler,
                                     errorHandler: errorHandler)
  }
  
  func getSchoolDetails(dbn: String, successHandler: @escaping (School) -> Void,
                        errorHandler: @escaping (String?) -> Void) {
    NetworkManager.shared.getSchoolDetails(dbn: dbn, successHandler: successHandler,
                                           errorHandler: errorHandler)
  }
  
}

/// Fake Data generation for testing purposes
// TODO - move this to unit testing when that's setup
extension DataManager {
  func createFakeSchool() -> School {
    var school = School()
    school.dbn = "21K728"
    school.name = "Liberation Diploma Plus High School Liberation Diploma Plus High School"
    school.sat.numberOfSATTestTakers = "10"
    school.sat.math = "369"
    school.sat.reading = "411"
    school.sat.writing = "373"
    return school
  }
}
