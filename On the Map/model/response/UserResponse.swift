//
//  UserResponse.swift
//  On the Map
//
//  Created by Marcos Mejias on 13/2/22.
//

import Foundation


struct UserResponse: Codable {
    let firstName: String
    let lastName: String
    let nickname: String
    let imageUrl: String
    let address: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case nickname = "nickname"
        case imageUrl = "_image_url"
        case address = "address"
    }
}
