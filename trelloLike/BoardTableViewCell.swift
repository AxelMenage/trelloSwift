//
//  BoardTableViewCell.swift
//  trelloLike
//
//  Created by Marion  on 17/05/2018.
//  Copyright © 2018 AxelM. All rights reserved.
//

import UIKit

class BoardTableViewCell: UITableViewCell {

    @IBOutlet weak var boardNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
