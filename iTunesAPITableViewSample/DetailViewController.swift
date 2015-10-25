//
//  DetailViewController.swift
//  iTunesAPITableViewSample
//
//  Created by 前田 晃良 on 2015/10/25.
//  Copyright (c) 2015年 A.M. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class DetailViewController: UIViewController {

    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var artWorkImageView: UIImageView!
    var previewURL:String = ""
    var musicDict:NSDictionary = [:]
    
    var player:AVPlayer = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        songTitleLabel.text = musicDict["trackName"] as? String
        albumLabel.text = musicDict["collectionCensoredName"] as? String
        
        var artWorkURL = musicDict["artworkUrl100"] as! String
        var imageURL = NSURL(string: artWorkURL)
        var imageData = NSData(contentsOfURL: imageURL!)
        var image = UIImage(data: imageData!)
        artWorkImageView.image = image
        
        //選択した要素の曲を再生する
        previewURL = musicDict["previewUrl"] as! String
        var musicURL = NSURL(string: previewURL) //stringをurlに変換
        player = AVPlayer(URL: musicURL) //urlの曲をavPlayerにセット
        player.play() //曲を再生
    }
}
