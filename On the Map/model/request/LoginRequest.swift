//
//  LoginRequest.swift
//  On the Map
//
//  Created by Marcos Mejias on 12/2/22.
//
// {"udacity": {"username": "xxx@xxx.com", "password": "xxxxxxx"}}

import Foundation

struct LoginRequest: Codable {
    let udacity: Udacity
}

struct Udacity: Codable {
    let username: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case username
        case password
    }
}
