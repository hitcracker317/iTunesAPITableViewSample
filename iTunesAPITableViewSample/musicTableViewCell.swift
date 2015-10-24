//
//  musicTableViewCell.swift
//  iTunesAPITableViewSample
//
//  Created by 前田 晃良 on 2015/10/24.
//  Copyright (c) 2015年 A.M. All rights reserved.
//

import UIKit

class musicTableViewCell: UITableViewCell {

    @IBOutlet weak var artWorkImageView: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var songTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
