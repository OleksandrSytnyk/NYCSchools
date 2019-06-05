//
//  APIRouter.swift
//  20190603-OleksandrSytnyk-NYCSchools
//
//  Created by Oleksandr Sytnyk on 6/3/19.
//  Copyright © 2019 Oleksandr Sytnyk. All rights reserved.
//

import Foundation
import Alamofire

public enum APIRouter: URLRequestConvertible {
  
  static let apiBaseURLPath = "https://data.cityofnewyork.us/resource"
  static let schoolURLPath = "/97mf-9njv.json"
  static let satScoresURLPath =  "/734v-jeq5.json"
  static let authenticationTokenParameterName = "X-App-Token"

  case schools
  case satScores

  public func asURLRequest() throws -> URLRequest {
    
    let result: (path: String, method: HTTPMethod, parameters: Parameters) = {
      switch self {
        
      case .schools:
        return (APIRouter.schoolURLPath, .get, [String: Any]())
        
      case .satScores:
        return (APIRouter.satScoresURLPath, .get, [String : Any]())
      }
    }()
    
    let url = try APIRouter.apiBaseURLPath.asURL()
    var urlRequest = URLRequest(url: url.appendingPathComponent(result.path))
    urlRequest.httpMethod = result.method.rawValue
    
    // OS: TODO - add token management mechanism instead of just hard coding here
    let token = "RPZsjdcqNHFdmF9OSo1L3N6Kb"
    urlRequest.setValue(token, forHTTPHeaderField: APIRouter.authenticationTokenParameterName)
    
    urlRequest.timeoutInterval = TimeInterval(10)
    
    let encoding = Alamofire.URLEncoding.default
    
    do {
      urlRequest = try encoding.encode(urlRequest, with: result.parameters)
    } catch {
      print("Error encoding url request.") //OS: TODO - add proper logging that has controls like warning, error, info, etc instead of always printing to console since we should be limiting logging prints depending on current environment
    }
    return urlRequest
  }
}
