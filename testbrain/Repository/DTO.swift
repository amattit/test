//
//  DTO.swift
//  testbrain
//
//  Created by 16997598 on 24.10.2020.
//  Copyright © 2020 Mikhail Seregin. All rights reserved.
//

import Foundation
struct AuthResponse: Decodable {
    
    let objectId: String
    let username: String
    let createdAt: String
    let updatedAt: String
    let sessionToken: String
    
}

struct MomentsResponse: Codable {
    let results: [MomentResponse]
}

struct MomentResponse: Codable {
    let objectID, createdAt, title: String
    let updatedAt: String?
    let mood, notes: String
    let photo: Photo?
    let creatorPID: CreatorPID?

    enum CodingKeys: String, CodingKey {
        case objectID = "objectId"
        case createdAt, updatedAt
        case title = "Title"
        case mood = "Mood"
        case notes = "Notes"
        case photo, creatorPID
    }
}

extension MomentsResponse: Hashable {}

extension MomentResponse: Hashable {}

extension CreatorPID: Hashable {}
extension Photo: Hashable {}
// MARK: - CreatorPID
struct CreatorPID: Codable {
    let type, className, objectID: String

    enum CodingKeys: String, CodingKey {
        case type = "__type"
        case className
        case objectID = "objectId"
    }
    
    init() {
        self.type = "Pointer"
        self.className = "_User"
        self.objectID = UserDefaults.standard.string(forKey: .userId) ?? ""
    }
}

// MARK: - Photo
struct Photo: Codable {
    let type, name, url: String

    enum CodingKeys: String, CodingKey {
        case type = "__type"
        case name
        case url
    }
}

struct CreateNoteRequest: Encodable {
    let mood, notes, title: String
    let creatorPID: CreatorPID
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case mood = "Mood"
        case notes = "Notes"
        case creatorPID
    }
}

struct CreateNoteResponse: Decodable {
    let objectId: String
    let createdAt: String
}
