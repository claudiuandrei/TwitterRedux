//
//  MenuViewCell.swift
//  Twitter
//
//  Created by Claudiu Andrei on 11/7/16.
//  Copyright © 2016 Claudiu Andrei. All rights reserved.
//

import UIKit

class MenuViewCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var titleLabel: UILabel!
    
    // Set the menu label
    var title: String? {
        didSet {
            textLabel?.text = title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
