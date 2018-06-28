//
//  ViewController.swift
//  TikiTweets
//
//  Created by Phan Quang Ha on 6/28/18.
//  Copyright © 2018 Phan Quang Ha. All rights reserved.
//

import UIKit
import SlackTextViewController

class ViewController: SLKTextViewController {
    
    var allTweets = [Tweet]()
    
    override var tableView: UITableView {
        get {
            return super.tableView!
        }
    }
    
    override class func tableViewStyle(for decoder: NSCoder) -> UITableViewStyle {
        return .plain
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configLayout () {
        self.rightButton.setTitle("Tweet", for: .normal) //need localized
        self.textInputbar.autoHideRightButton = false

        self.isInverted = false
        
        self.textView.maxNumberOfLines = 6
        self.tableView.reloadData()
    }

    func configDataSource () {
        
    }
    
}

extension ViewController {
    override func didPressRightButton(_ sender: Any?) {
        self.textView.refreshFirstResponder()
        
        let text = self.textView.text
        if let result = text?.toTweets(50).map({ Tweet(text: "\($0) (\($0.count))") }) {
            self.allTweets.append(contentsOf: result)
            self.tableView.reloadData()
        }
        
        super.didPressRightButton(sender)
    }
}

extension ViewController {
    
    // MARK: - UITableViewDataSource Methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.allTweets.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return self.tweetCellAt(indexPath)
    }
    
    func tweetCellAt(_ indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "CellID") else {
            let cell =  UITableViewCell(style: .default, reuseIdentifier: "CellID")
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.lineBreakMode = .byWordWrapping
            cell.transform = self.tableView.transform
            return cell
        }
        
        if indexPath.row > allTweets.count {
            cell.textLabel?.text = ""
            return cell
        }
        
        cell.transform = self.tableView.transform
        
        let tweet = self.allTweets[indexPath.row]
        
        cell.textLabel?.text = tweet.text
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
}

