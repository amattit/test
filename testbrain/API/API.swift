//
//  API.swift
//  testbrain
//
//  Created by 16997598 on 22.10.2020.
//  Copyright © 2020 Mikhail Seregin. All rights reserved.
//

import Foundation
import Networking

enum API {
    enum User {
        case login
    }
    
    enum Moments {
        case all
        case deleteBy(String)
        case create(CreateNoteRequest)
    }
}

extension API.Moments: APICall {
    var path: String {
        switch self {
        case .all:
            return "/classes/Moments"
        case .deleteBy(let id):
            return "/classes/Moments/\(id)"
        case .create:
            return "/classes/Moments"
        }
    }
    
    var method: String {
        switch self {
        case .all:
            return "GET"
        case .deleteBy:
            return "DELETE"
        case .create:
            return "POST"
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .create:
            return ["X-Parse-Application-Id": APIConfig.applicationId,
            "X-Parse-REST-API-Key":APIConfig.apiKey,
            "X-Parse-Revocable-Session": APIConfig().sessionId,
            "Content-Type":"application/json"]
        default:
            return ["X-Parse-Application-Id": APIConfig.applicationId,
            "X-Parse-REST-API-Key":APIConfig.apiKey,
            "X-Parse-Revocable-Session": APIConfig().sessionId,
            "content-type":"application/json"]
        }
        
    }
    
    var query: [String : String]? {
        return nil
    }
    
    func body() throws -> Data? {
        switch self {
        case .create(let request):
            return try JSONEncoder().encode(request)
        default:
            return nil
        }
    }
    
    
}

extension API.User: APICall {
    var path: String {
        switch self {
        case .login:
            return "/login"
        }
    }
    
    var method: String {
        switch self {
        case .login:
            return "GET"
        }
    }
    
    var headers: [String : String]? {
        return ["X-Parse-Application-Id": APIConfig.applicationId,
                "X-Parse-REST-API-Key":APIConfig.apiKey,
                "X-Parse-Revocable-Session": APIConfig().sessionId]
    }
    
    var query: [String : String]? {
        switch self {
        case .login:
            return ["username":"_silo@mail.ru",
                    "password":"123456"]
        }
    }
    
    func body() throws -> Data? {
        nil
    }
}

