//
//  ViewController.swift
//  iTunesAPITableViewSample
//
//  Created by 前田 晃良 on 2015/10/24.
//  Copyright (c) 2015年 A.M. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var musicTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        var nib:UINib = UINib(nibName:"musicTableViewCell", bundle: nil)
        musicTableView.registerNib(nib, forCellReuseIdentifier:"musicTableViewCell")
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: musicTableViewCell = tableView.dequeueReusableCellWithIdentifier("musicTableViewCell", forIndexPath: indexPath) as! musicTableViewCell
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

