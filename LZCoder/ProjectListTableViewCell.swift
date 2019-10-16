//
//  ProjectListTableViewCell.swift
//  LZCoder
//
//  Created by Dhanesh Gosai on 16/10/19.
//  Copyright © 2019 kehlin swain. All rights reserved.
//

import UIKit

class ProjectListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblCode: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
