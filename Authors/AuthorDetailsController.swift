//
//  AuthorDetailsController.swift
//  AuthorsDemo
//
//  Created by Kaustubh on 27/06/20.
//  Copyright © 2020 KaustubhtestApp. All rights reserved.
//

import UIKit
import SwiftSpinner

class AuthorDetailsController: UIViewController {

    @IBOutlet weak var postsTableView: UITableView!
    var postsDataSource = PostsDataSource()
    var _author: Author?
    var author: Author? {
        set {
            self._author = newValue
        }
        get {
            return self._author
        }
    }
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    func showAuthorDetails() {
        
        if let author = self._author {
            self.title = author.name
            self.usernameLabel.text = "id: \(author.id)\nEmail: \(author.email)"
            self.addressLabel.text = author.getAddress()
            self.postsTableView.dataSource = postsDataSource
            SwiftSpinner.show("Loading posts...")
            AuthorService().fetchPostsFor(author: String(author.id)) { [weak self] posts, error in
                guard let self = self else {return}
                DispatchQueue.main.async{
                SwiftSpinner.hide()
                if error == nil , let posts = posts {
                    self.postsDataSource.appendPosts(posts: posts)
                    self.postsTableView.reloadData()
                    }
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showAuthorDetails()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

class PostsDataSource: NSObject {
    var posts = [Post]()
    
    func appendPosts(posts: [Post]) {
        self.posts.append(contentsOf: posts)
    }
}

extension PostsDataSource : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "post", for: indexPath) as? PostCell else {
            return UITableViewCell()
        }
        cell.setData(post: posts[indexPath.row])
        return cell
    }
    
    
}
