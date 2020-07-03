//
//  PostDetailsViewController.swift
//  AuthorsDemo
//
//  Created by Kaustubh on 03/07/20.
//  Copyright © 2020 KaustubhtestApp. All rights reserved.
//

import UIKit
import SwiftSpinner

class PostDetailsViewController: UIViewController {

    @IBOutlet weak var commentsTableView: UITableView!
    @IBOutlet weak var postTitleLable: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var bodyLabelHeightConstraint: NSLayoutConstraint!
    var post: Post?
    var commentsDataSource = CommentsDataSource()
    override func viewDidLoad() {
        super.viewDidLoad()
        if let post = self.post {
            postTitleLable.text = post.title
            bodyLabel.text = post.body
            self.commentsTableView.dataSource = commentsDataSource
            SwiftSpinner.show("Loading comments...")
            AuthorService().fetchCommentsFor(post: String(post.id), completion: { comments,error in
              DispatchQueue.main.async{
                SwiftSpinner.hide()
                if let comments = comments, comments.count > 0, error == nil {
                    self.commentsDataSource.appendComments(comments: comments)
                    self.commentsTableView.reloadData()
                }
                }
            })
        }
        
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

class CommentsDataSource: NSObject {
    var comments = [Comment]()
    
    func appendComments(comments: [Comment]) {
        self.comments.append(contentsOf: comments)
    }
}

extension CommentsDataSource : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")

        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
            cell?.textLabel?.numberOfLines = 0

            cell?.textLabel!.text = comments[indexPath.row].body

            return cell!
        }
            
        return UITableViewCell()
        
    }
}
