//
//  AuthorDetailsController.swift
//  AuthorsDemo
//
//  Created by Kaustubh on 27/06/20.
//  Copyright © 2020 KaustubhtestApp. All rights reserved.
//

import UIKit
import SwiftSpinner

protocol ShowPostDetailsProtocol: class {
    func showDetails(data: Post)
}

class AuthorDetailsController: UIViewController, ShowPostDetailsProtocol {
    
    @IBOutlet weak var postsTableView: UITableView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!

    func showDetails(data: Post) {
        self.performSegue(withIdentifier: "postdetails", sender: data)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "postdetails" {
            guard let object = sender as? Post else {
                return
            }
            let dvc = segue.destination as! PostDetailsViewController
            dvc.post = object
        }
    }
    
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
        
    func showAuthorDetails() {
        
        if let author = self._author {
            self.title = author.name
            self.emailLabel.text = author.email
            self.addressLabel.text = author.getAddress()
            self.postsTableView.dataSource = postsDataSource
            self.postsTableView.delegate = postsDataSource
            postsDataSource.delegate = self
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
    }
}

class PostsDataSource: NSObject {
    var posts = [Post]()
    weak var delegate: ShowPostDetailsProtocol!
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

extension PostsDataSource : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate.showDetails(data: posts[indexPath.row])
    }
}


