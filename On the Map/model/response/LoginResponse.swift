//
//  LoginResponse.swift
//  On the Map
//
//  Created by Marcos Mejias on 12/2/22.
//

import Foundation


struct LoginResponse: Codable {
    let account: Account
    let session: Session
}

struct Account: Codable {
    let key: String?
    let registered: Bool
}

struct Session: Codable {
    let id: String?
    let expiration: String?
}
