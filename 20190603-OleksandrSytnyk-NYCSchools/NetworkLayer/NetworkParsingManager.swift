//
//  NetworkParsingManager.swift
//  20190603-OleksandrSytnyk-NYCSchools
//
//  Created by Oleksandr Sytnyk on 6/3/19.
//  Copyright © 2019 Oleksandr Sytnyk. All rights reserved.
//

import SwiftyJSON

struct NetworkParsingManager {
  static let shared = NetworkParsingManager()
  
  enum ParsingError: Error {
    case invalidSchoolData
    case invalidSchoolDetailsData
    case noSchoolDetailsData
    
    func errorDescription() -> String {
      switch self {
      case .invalidSchoolData:
        return "Parsing failed: invalid school data provided.".localized
      case .invalidSchoolDetailsData:
        return "Parsing failed: invalid school details data provided.".localized
      case .noSchoolDetailsData:
        return "Data base doesn't contain details for this school.".localized
      }
    }
  }
  
  static func parseSchools(_ json: JSON) -> [School] {
    
    //OS: TODO - add validation
    
    var schools = [School]()
    
    for jsonSchool in json {
      do {
        let school = try self.parseSchool(jsonSchool)
        schools.append(school)
      } catch {
        continue
      }
    }
    return schools
  }
  
  static func parseSchool(_ jsonSchool: (String, JSON)) throws -> School {
    var school = School()
    
    guard let dbn = jsonSchool.1["dbn"].string,
      let schoolName = jsonSchool.1["school_name"].string,
      let address = jsonSchool.1["primary_address_line_1"].string,
      let latitude = jsonSchool.1["latitude"].string,
      let longitude = jsonSchool.1["longitude"].string,
      let studentsNumber = jsonSchool.1["total_students"].string else {
        throw ParsingError.invalidSchoolData
    }
    
    school.dbn = dbn
    school.name = schoolName
    school.address = address
    school.latitude = Double(latitude) ?? 0.0
    school.longitude = Double(longitude) ?? 0.0
    school.studentsNumber = studentsNumber
    
    return school
  }
  
  func parseSchoolDetails(_ json: JSON, dbn2: String) throws -> School {
    //OS: TODO - add validation
    
    var school = School()
    
    //Here we define the index of the requested school in the json array to find its details later.
    guard let requestedJsonSchool = (json.filter {
      $1["dbn"].string == dbn2
      }.first)?.1 else {
        throw ParsingError.noSchoolDetailsData
    }
    
    guard let schoolName = requestedJsonSchool["school_name"].string,
      let numberOfSATTestTakers = requestedJsonSchool["num_of_sat_test_takers"].string,
      let dbn = requestedJsonSchool["dbn"].string,
      let mathSAT = requestedJsonSchool["sat_math_avg_score"].string,
      let readingSAT = requestedJsonSchool["sat_critical_reading_avg_score"].string,
      let writingSat = requestedJsonSchool["sat_writing_avg_score"].string else {
        throw ParsingError.invalidSchoolDetailsData
    }
    
    school.name = schoolName
    school.sat.numberOfSATTestTakers = numberOfSATTestTakers
    school.dbn = dbn
    school.sat.math = mathSAT
    school.sat.reading = readingSAT
    school.sat.writing = writingSat
    
    return school
  }
}
