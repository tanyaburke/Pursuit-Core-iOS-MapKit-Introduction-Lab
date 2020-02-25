//
//  SchoolsAPIClient.swift
//  MapKitLab
//
//  Created by Tanya Burke on 2/24/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import Foundation
import NetworkHelper

struct SchoolAPIClient {
  static func fetchData(completion: @escaping (Result<[School], AppError>) -> ()) {
    let endpointURLString = "https://data.cityofnewyork.us/resource/uq7m-95z8.jsons"
    guard let url = URL(string: endpointURLString) else {
      completion(.failure(.badURL(endpointURLString)))
      return
    }
    let request = URLRequest(url: url)
    NetworkHelper.shared.performDataTask(with: request) { (result) in
      switch result {
      case .failure(let appError):
        completion(.failure(.networkClientError(appError)))
      case .success(let data):
        do {
          let dataArray = try JSONDecoder().decode([School].self, from: data)
            completion(.success(dataArray))
        } catch {
          completion(.failure(.decodingError(error)))
        }
      }
    }
  }
}

