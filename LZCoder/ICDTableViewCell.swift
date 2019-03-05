//
//  ICDTableViewCell.swift
//  LZCoder
//
//  Created by Dhanesh Gosai on 05/03/19.
//  Copyright © 2019 kehlin swain. All rights reserved.
//

import UIKit

class ICDTableViewCell: UITableViewCell {

    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var btnCheckBox: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
