//
//  LocalStorage.swift
//  Authors
//
//  Created by Kaustubh on 26/06/20.
//  Copyright © 2020 KaustubhtestApp. All rights reserved.
//

import Foundation


class LocalStorage {
    static let shared = LocalStorage()
    
    let shoppingListKey = "shopping_list"
    let webFeeds = "webfeeds"
    let lastDate = "lastupdateddate"
    let authors_key = "authors"
    
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
        saveData(data: authors, for: authors_key)
    }
    
    func savePostsOf(authorId: String, posts: [Post]) {
        saveData(data: posts, for: authorId)
    }
    
    func saveCommentsFor(postId: String, comments: [Comment]) {
        saveData(data: comments, for: postId)
    }
    
    func getAuthors() -> Authors {
        var authors = [Author]()
        if let data = self.data(for: authors_key), let parsedData = (data as? Authors) {
            authors = parsedData
        }
        return authors
    }
    
    func getPostsOf(authorId: String) -> Posts {
        var posts = [Post]()
        if let data = self.data(for: authorId), let parsedData = (data as? Posts) {
            posts = parsedData
        }
        
        return posts
    }
    
    func getCommentsFor(postId: String) -> Comments{
        var comments = [Comment]()
        if let data = self.data(for: postId), let parsedData = (data as? Comments) {
            comments = parsedData
        }
        
        return comments
    }
    
    func saveData(data: Any, for key: String) {
//        UserDefaults.standard.set(data, forKey: key)
//        userDefaults.synchronize()
    }
    
    func data(for key: String) -> Any? {
        if let data = UserDefaults.standard.object(forKey: key) {
            return data
        }
        return nil
}
}
