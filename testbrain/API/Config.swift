//
//  Config.swift
//  testbrain
//
//  Created by 16997598 on 22.10.2020.
//  Copyright © 2020 Mikhail Seregin. All rights reserved.
//

import Foundation

struct APIConfig {
    static let host = "https://alfedyakin.back4app.io"
    static let apiKey = "9y60jMi8YEbRgm0Ywd7sU84kAecdIY2Fd9nqqzMu"
    static let applicationId = "Tkv6D16fLIi3FuUB0xY4ftQYNuGRIghZv9QQR06B"
    
    var sessionId: String {
        UserDefaults.standard.string(forKey: .sessionKey) ?? "1"
    }
}

extension String {
    static let sessionKey = "sessionKey"
    static let userId = "userId"
}
