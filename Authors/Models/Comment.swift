//
//  Comment.swift
//  Authors
//
//  Created by Kaustubh on 26/06/20.
//  Copyright © 2020 KaustubhtestApp. All rights reserved.
//

import Foundation

struct Comment: Codable {
    let id: Int
    let date, body, userName, email: String
    let avatarURL: String
    let postID: Int

    enum CodingKeys: String, CodingKey {
        case id, date, body, userName, email
        case avatarURL = "avatarUrl"
        case postID = "postId"
    }
}

typealias Comments = [Comment]
