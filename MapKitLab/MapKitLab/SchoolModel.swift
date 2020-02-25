//
//  SchoolModel.swift
//  MapKitLab
//
//  Created by Tanya Burke on 2/24/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import Foundation

//   let empty = try? newJSONDecoder().decode(Empty.self, from: jsonData)

//typealias Empty = [[String: String]]

//struct SchoolLocation: Codable {
//    let empty: School
//}
struct School: Codable {
   let schoolName: String
   let latitude: String
   let longitude: String

    private enum CodingKeys: String, CodingKey{
    case schoolName = "school_name"
        case latitude
        case longitude
}
    
    
    

    
}
