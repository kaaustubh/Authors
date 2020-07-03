//
//  ViewController.swift
//  Authors
//
//  Created by Kaustubh on 24/06/20.
//  Copyright © 2020 KaustubhtestApp. All rights reserved.
//

import UIKit
import SwiftSpinner
protocol ShowDetailsProtocol: class {
    func showDetails(data: Author)
}

class ViewController: UIViewController, ShowDetailsProtocol {

    @IBOutlet weak var authorsTableView: UITableView!
    var authorsDataSource = AuthorsDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.authorsTableView.dataSource = authorsDataSource
        self.authorsTableView.delegate = authorsDataSource
        authorsDataSource.delegate = self
        
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
    
    func showDetails(data: Author) {
        self.performSegue(withIdentifier: "authordetails", sender: data)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "authordetails" {
            guard let object = sender as? Author else {
                return
            }
            let dvc = segue.destination as! AuthorDetailsController
            dvc.author = object
        }
    }
}

class AuthorsDataSource: NSObject {
    var authors = [Author]()
    weak var delegate: ShowDetailsProtocol!
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
extension AuthorsDataSource : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.delegate.showDetails(data: authors[indexPath.row])
    }
}

