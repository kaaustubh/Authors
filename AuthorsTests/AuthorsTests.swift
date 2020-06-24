//
//  AuthorsTests.swift
//  AuthorsTests
//
//  Created by Kaustubh on 24/06/20.
//  Copyright © 2020 KaustubhtestApp. All rights reserved.
//

import XCTest
@testable import Authors

class AuthorsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchAuthors() throws {
         let postsExpectation = expectation(description: "Get Authors")
               _ = AuthorService().fetchAuthors(completion: { posts,error in
                   if let posts = posts, posts.count > 0 {
                       postsExpectation.fulfill()
                   }
               })
         waitForExpectations(timeout: 3)
    }
    func testFetchPostsForAuthors() throws {
         let postsExpectation = expectation(description: "Get Posts")
        _ = AuthorService().fetchPostsFor(author: "12", completion: { posts,error in
                   if let posts = posts, posts.count > 0 {
                       postsExpectation.fulfill()
                   }
               })
         waitForExpectations(timeout: 3)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
