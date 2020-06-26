//
//  AuthorTableViewCell.swift
//  Authors
//
//  Created by Kaustubh on 26/06/20.
//  Copyright © 2020 KaustubhtestApp. All rights reserved.
//

import UIKit

class AuthorTableViewCell: UITableViewCell {

    @IBOutlet weak var authorNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(author: Author) {
        self.authorNameLabel.text = author.name;
    }
}
