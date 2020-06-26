//
//  ViewController.swift
//  Authors
//
//  Created by Kaustubh on 24/06/20.
//  Copyright © 2020 KaustubhtestApp. All rights reserved.
//

import UIKit
import SwiftSpinner

class ViewController: UIViewController {

    @IBOutlet weak var authorsTableView: UITableView!
    var authorsDataSource = AuthorsDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.authorsTableView.dataSource = authorsDataSource
        SwiftSpinner.show("Loading...")
        AuthorService().fetchAuthors() {[weak self] authors, error in
            guard let self = self else {return}
            DispatchQueue.main.async{
                SwiftSpinner.hide()
                if error == nil , let authors = authors {
                    self.authorsDataSource.appendAuthor(authors: authors)
                    self.authorsTableView.reloadData()
                }
            }
        }
        // Do any additional setup after loading the view.
    }
}



class AuthorsDataSource: NSObject {
    var authors = [Author]()
    
    func appendAuthor(authors: [Author]) {
        self.authors.append(contentsOf: authors)
    }
}

extension AuthorsDataSource : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        authors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "author", for: indexPath) as? AuthorTableViewCell else {
            return UITableViewCell()
        }
        cell.setData(author: authors[indexPath.row])
        return cell
    }
    
    
}
