//
//  Post.swift
//  Authors
//
//  Created by Kaustubh on 24/06/20.
//  Copyright © 2020 KaustubhtestApp. All rights reserved.
//

import Foundation


// MARK: - Post
struct Post: Codable {
    let id: Int
    let date, title, body: String
    let imageURL: String
    let authorID: Int

    enum CodingKeys: String, CodingKey {
        case id, date, title, body
        case imageURL = "imageUrl"
        case authorID = "authorId"
    }
}
