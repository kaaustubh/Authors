//
//  Author.swift
//  Authors
//
//  Created by Kaustubh on 24/06/20.
//  Copyright © 2020 KaustubhtestApp. All rights reserved.
//

import Foundation

// MARK: - Author
struct Author: Codable {
    let id: Int
    let name, userName, email: String
    let avatarURL: String
    let address: Address

    enum CodingKeys: String, CodingKey {
        case id, name, userName, email
        case avatarURL = "avatarUrl"
        case address
    }
    
    func getAddress() -> String {
        return "\(self.address.latitude), \(self.address.longitude)"
    }
}

// MARK: - Address
struct Address: Codable {
    let latitude, longitude: String
}

typealias Authors = [Author]
