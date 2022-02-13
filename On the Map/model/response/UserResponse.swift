//
//  UserResponse.swift
//  On the Map
//
//  Created by Marcos Mejias on 13/2/22.
//

import Foundation


struct UserResponse: Codable {
    let lastName: String
    let firstName: String
    let key: String

    
    enum CodingKeys: String, CodingKey {
        case lastName = "last_name"
        case firstName = "first_name"
        case key = "key"
    }
}
