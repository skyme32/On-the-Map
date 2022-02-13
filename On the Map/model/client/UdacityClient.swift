//
//  UdacityClient.swift
//  On the Map
//
//  Created by Marcos Mejias on 12/2/22.
//

import Foundation

class UdacityClient {
    
    // MARK: Endpoints
    
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"
        static let baseSignUp = "https://auth.udacity.com"
        
        case login
        case webAuth
        case studentLocations(String, Int)
        
        var stringValue: String {
            switch self {
                case .login:
                    return Endpoints.base + "/session"
                case .webAuth:
                    return Endpoints.baseSignUp + "/sign-up"
                case .studentLocations(let orderBy, let limit):
                    return Endpoints.base + "/StudentLocation?order=-\(orderBy)&limit=\(limit)"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    // MARK: Request Methods
    
    class func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        let body = LoginRequest(udacity: Udacity(username: username, password: password))
                
        MethodAPI.taskForPOSTRequest(url: Endpoints.login.url, responseType: LoginResponse.self, body: body) { response, error in
            if let response = response {
                completion(response.account.registered, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    class func logout(completion: @escaping () -> Void) {
        MethodAPI.taskForDELETERequest(url: Endpoints.login.url, responseType: Session.self) { response, error in
            if response != nil {
                completion()
            }
        }
    }
    
    // MARK: Request Student Location Methods
    
    class func getStudentLocationList(limit: Int, order: String, completion: @escaping ([StudentLocation], Error?) -> Void) {
        let urlExtension = Endpoints.studentLocations(order, limit).url
        MethodAPI.taskForGETRequest(url: urlExtension, responseType: StudentResults.self) { response, error in
            if let response = response {
                completion(response.results, nil)
            } else {
                completion([], error)
            }
        }
    }
}

