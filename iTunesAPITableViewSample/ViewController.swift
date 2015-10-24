//
//  ViewController.swift
//  iTunesAPITableViewSample
//
//  Created by 前田 晃良 on 2015/10/24.
//  Copyright (c) 2015年 A.M. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var musicTableView: UITableView!
    
    var jsonDict:NSDictionary = [:]
    var musicArray:NSArray = []
    var musicCount:Int = 0
    
    var player:AVPlayer = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        var nib:UINib = UINib(nibName:"musicTableViewCell", bundle: nil)
        musicTableView.registerNib(nib, forCellReuseIdentifier:"musicTableViewCell")
        
        self.getAPI()
    }
    
    func getAPI(){
        //iTunesのAPIを叩いてJSONを取得するメソッド
        
        var urlString = "https://itunes.apple.com/search?term=beatles&country=JP&lang=ja_jp&media=music" //API(url)の文字列を生成する
        var url = NSURL(string: urlString) //URLの文字列をURL型に変換
        var data = NSData(contentsOfURL: url!) //URLをData型に変換
        jsonDict = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as! NSDictionary //jsonに変換
        println(jsonDict)
        
        self.setMusicInfo()
    }
    
    func setMusicInfo(){
        //曲情報を切り替えた際に取得した曲情報をセットするメソッド
        
        //iTunes APIから取得した曲数
        var musicCountString:NSNumber = jsonDict["resultCount"] as! NSNumber
        musicCount = Int(musicCountString) //NSNumberをIntに変換
        println("取得した曲数\(musicCount)")
        
        musicArray = jsonDict["results"] as! NSArray //API叩いて取得した曲の情報(NSDictionary)を格納する配列
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicCount
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: musicTableViewCell = tableView.dequeueReusableCellWithIdentifier("musicTableViewCell", forIndexPath: indexPath) as! musicTableViewCell
        
        //アルバム名をセット
        cell.albumLabel.text = musicArray[indexPath.row]["collectionCensoredName"] as? String
        
        //曲名をセット
        cell.songTitleLabel.text = musicArray[indexPath.row]["trackName"] as? String
        
        //アートワークをセット
        var artWorkURL = musicArray[indexPath.row]["artworkUrl100"] as! String
        var imageURL = NSURL(string: artWorkURL)
        var imageData = NSData(contentsOfURL: imageURL!)
        var image = UIImage(data: imageData!)
        cell.artWorkImageView.image = image
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //選択した要素の曲を再生する
        
        var previewULR = musicArray[indexPath.row]["previewUrl"] as! String //曲のurl(string)を取得
        var musicURL = NSURL(string: previewULR) //stringをurlに変換
        player = AVPlayer(URL: musicURL) //urlの曲をavPlayerにセット
        player.play() //曲を再生
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

