//
//  StudentLocation.swift
//  On the Map
//
//  Created by Marcos Mejias on 13/2/22.
//

import Foundation
import MapKit


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
    
    var uniqueKey: String
    var firstName: String
    var lastName:  String
    var mapString: String
    var mediaURL:  String
    var latitude:  Double
    var longitude: Double
    
    init(uniqueKey: String? = "",
         firstName: String? = "",
         lastName: String? = "",
         mapString: String? = "",
         mediaURL: String? = "",
         latitude: Double? = 0.0,
         longitude: Double? = 0.0
    ) {
        self.uniqueKey = uniqueKey!
        self.firstName = firstName!
        self.lastName  = lastName!
        self.mapString = mapString!
        self.mediaURL = mediaURL!
        self.latitude = latitude!
        self.longitude = longitude!
    }
    
}
