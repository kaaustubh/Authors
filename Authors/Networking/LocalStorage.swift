//
//  LocalStorage.swift
//  Authors
//
//  Created by Kaustubh on 26/06/20.
//  Copyright © 2020 KaustubhtestApp. All rights reserved.
//

import Foundation
import DefaultsKit

class LocalStorage {
    static let shared = LocalStorage()
    let defaults = Defaults()
    let shoppingListKey = "shopping_list"
    let webFeeds = "webfeeds"
    let lastDate = "lastupdateddate"
    let authors_key = "authors"
    let key_authors = Key<Authors>("personKey")
    
    let userDefaults = UserDefaults.standard
    
    func saveDate(date: Date) {
        userDefaults.set(date, forKey: lastDate)
        userDefaults.synchronize()
    }
    
    func lastUpdatedDate() -> Date? {
        guard let date = userDefaults.object(forKey: lastDate) as? Date else {
            return nil
        }
        return date
    }
    
    func saveAuthors(authors: [Author]) {
        defaults.set(authors, for: key_authors)
    }
    
    func savePostsOf(authorId: String, posts: [Post]) {
        let key = Key<Posts>(authorId)
        defaults.set(posts, for: key)
    }
    
    func saveCommentsFor(postId: String, comments: [Comment]) {
        let key = Key<Comments>(postId)
        defaults.set(comments, for: key)
    }
    
    func getAuthors() -> Authors {
        var authors = [Author]()
        if let data = defaults.get(for: key_authors) {
            authors = data
        }
        return authors
    }
    
    func getPostsOf(authorId: String) -> Posts {
        var posts = [Post]()
        let key = Key<Posts>(authorId)
        
        if let data = defaults.get(for: key) {
            posts = data
        }
        return posts
    }
    
    func getCommentsFor(postId: String) -> Comments{
        var comments = [Comment]()
        let key = Key<Comments>(postId)
        
        if let data = defaults.get(for: key) {
            comments = data
        }
        return comments
    }
}
