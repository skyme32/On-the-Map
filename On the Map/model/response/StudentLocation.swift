//
//  StudentLocation.swift
//  On the Map
//
//  Created by Marcos Mejias on 13/2/22.
//

import Foundation


enum OrderByStudent {
    static let updatedAt = "updatedAt"
    static let uniqueKey = "uniqueKey"
    static let firstName = "firstName"
    static let lastName = "lastName"
    static let mapString = "mapString"
    static let mediaURL = "mediaURL"
    static let latitude = "latitude"
    static let longitude = "longitude"
}

enum FilterByStudent {
    static let SMALL = 10
    static let MEDIUM = 100
    static let BIG = 200
}

struct StudentResults: Codable {
    let results: [StudentLocation]
}

struct StudentLocation: Codable {
    let uniqueKey: String
    let firstName: String
    let lastName:  String
    var mapString: String
    var mediaURL:  String
    var latitude:  Double
    var longitude: Double
}
