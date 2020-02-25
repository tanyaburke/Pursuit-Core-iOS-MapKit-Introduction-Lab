//
//  ParseJson.swift
//  MapKitLab
//
//  Created by Tanya Burke on 2/24/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import Foundation


public enum LocationServiceError: Error {
  case resourcePathDoesNotExist
  case contentsNotFound
  case decodingError(Error)
}

final class SchoolSupplyService {
  public static func fetchLocation() throws -> [School] {
    guard let path = Bundle.main.path(forResource: "Schools", ofType: "json") else {
      throw LocationServiceError.resourcePathDoesNotExist
    }
    guard let json = FileManager.default.contents(atPath: path) else {
      throw  LocationServiceError.contentsNotFound
    }
    do {
      let schoolData = try JSONDecoder().decode([School].self, from: json)
      return schoolData
    } catch {
      throw LocationServiceError.decodingError(error)
    }
  }
}
