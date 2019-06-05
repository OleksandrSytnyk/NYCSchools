  //
  //  NetworkManager.swift
  //  20190603-OleksandrSytnyk-NYCSchools
  //
  //  Created by Oleksandr Sytnyk on 6/3/19.
  //  Copyright © 2019 Oleksandr Sytnyk. All rights reserved.
  //
  
  import Foundation
  import Alamofire
  import SwiftyJSON
  
  struct NetworkManager {
    static let shared = NetworkManager()
    
    func getSchools(successHandler: @escaping ([School]) -> Void,
                    errorHandler: @escaping (String?) -> Void) {
      var json: JSON = JSON.null
      
      AF.request(APIRouter.schools)
        .responseJSON { response in
          
          guard case .success = response.result else {
            errorHandler(response.error?.localizedDescription)
            return
          }
          
          if let value = response.value {
            json = JSON(value)
            
            let schools = NetworkParsingManager.parseSchools(json)
            successHandler(schools)
          }
      }
    }
    
    func getSchoolDetails(dbn: String, successHandler: @escaping (School) -> Void,
                          errorHandler: @escaping (String?) -> Void) {
      var json: JSON = JSON.null
      
      AF.request(APIRouter.satScores)
        .responseJSON { response in
          
          guard case .success = response.result else {
            errorHandler(response.error?.localizedDescription)
            return
          }
          guard let value = response.value else {
            errorHandler("Response doesn't contain data".localized)
            return
          }
          json = JSON(value)
          
          
          do {
            let schoolDetails = try NetworkParsingManager.shared.parseSchoolDetails(json, dbn2: dbn)
            successHandler(schoolDetails)
          } catch  let parsingError as NetworkParsingManager.ParsingError {
            errorHandler(parsingError.errorDescription())
          } catch {
            errorHandler("Unknown fetching error.".localized)
          }
      }
    }
  }
