//
//  AuthRepository.swift
//  testbrain
//
//  Created by 16997598 on 22.10.2020.
//  Copyright © 2020 Mikhail Seregin. All rights reserved.
//

import Foundation
import Networking
import Combine

struct Repository: WebRepository {
    var session: URLSession = .shared
    
    var baseURL: String = APIConfig.host
    
    var queue: DispatchQueue = DispatchQueue(label: "AuthRepository")
    
    func auth() -> AnyPublisher<AuthResponse, Error> {
        call(endpoint: API.User.login)
    }
    
    func fetchMoments() -> AnyPublisher<MomentsResponse, Error> {
        call(endpoint: API.Moments.all)
    }
    
    func deleteMoment(id: String) -> AnyPublisher<Networking.Empty, Error> {
        call(endpoint: API.Moments.deleteBy(id))
    }
    
    func createNote(request: CreateNoteRequest) -> AnyPublisher<CreateNoteResponse, Error> {
        call(endpoint: API.Moments.create(request))
    }
}

