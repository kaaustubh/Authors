//
//  PostCell.swift
//  AuthorsDemo
//
//  Created by Kaustubh on 27/06/20.
//  Copyright © 2020 KaustubhtestApp. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(post: Post){
        self.titleLabel.text = post.title
    }
}
