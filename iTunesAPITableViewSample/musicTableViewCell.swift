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
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var songTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setMusicInfo(#album:String,songTitle:String,artWork:String){
        //アルバム名をセット
        albumLabel.text = album
        
        //曲名をセット
        songTitleLabel.text = songTitle
        
        //アートワークをセット
        var artWorkURL = artWork
        var imageURL = NSURL(string: artWorkURL)
        var imageData = NSData(contentsOfURL: imageURL!)
        var image = UIImage(data: imageData!)
        artWorkImageView.image = image

    }
    
}
