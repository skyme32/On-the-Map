//
//  ErrorResponse.swift
//  On the Map
//
//  Created by Marcos Mejias on 12/2/22.
//
// {"status":xxx,"error":"xxxxxx"}

import Foundation


struct ErrorResponse: Codable {
    let status: Int
    let error: String
    
    enum CodingKeys: String, CodingKey {
        case status
        case error
    }
}

extension ErrorResponse: LocalizedError {
    var errorDescription: String? {
        return error
    }
}
