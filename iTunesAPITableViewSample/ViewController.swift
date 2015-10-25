//
//  ViewController.swift
//  iTunesAPITableViewSample
//
//  Created by 前田 晃良 on 2015/10/24.
//  Copyright (c) 2015年 A.M. All rights reserved.
//

import UIKit
import AFNetworking

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate{

    @IBOutlet weak var musicTableView: UITableView!
    @IBOutlet weak var musicSearchBar: UISearchBar!
    
    var jsonDict:NSDictionary = [:]
    var musicArray:NSArray = []
    var musicDictionary:NSDictionary = [:]
    var musicCount:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        var nib:UINib = UINib(nibName:"musicTableViewCell", bundle: nil)
        musicTableView.registerNib(nib, forCellReuseIdentifier:"musicTableViewCell")
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        //サーチバーに入力した情報を元に曲を取得
        
        musicSearchBar.resignFirstResponder()
        
        let searchText = searchBar.text.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        
        if((searchText) != nil){
            self.getAPI(searchText:searchText!)
        }
    }
    
    func getAPI(#searchText:String){
        //iTunesのAPIを叩いてJSONを取得するメソッド
        
        var urlString = "https://itunes.apple.com/search?term=\(searchText)&country=JP&lang=ja_jp&media=music" //API(url)の文字列を生成する
        
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
        
        self.musicTableView.reloadData() // 再描画
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicCount
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        musicDictionary = musicArray[indexPath.row] as! NSDictionary
        
        let cell: musicTableViewCell = tableView.dequeueReusableCellWithIdentifier("musicTableViewCell", forIndexPath: indexPath) as! musicTableViewCell
        
        var albumString = musicDictionary["collectionCensoredName"] as? String
        var songTitleString = musicDictionary["trackName"] as? String
        var artWorkStoring = musicDictionary["artworkUrl100"] as! String
        
        cell.setMusicInfo(album: albumString!, songTitle: songTitleString!, artWork: artWorkStoring)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        musicDictionary =  musicArray[indexPath.row] as! NSDictionary
        self.performSegueWithIdentifier("detail", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "detail"){
            
            //遷移先に選択したセルのdicitionaryを渡す
            var detailViewController = segue.destinationViewController as! DetailViewController
            detailViewController.musicDict = musicDictionary
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

