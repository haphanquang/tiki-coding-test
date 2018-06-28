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
    
    var allTweets: [Tweet] = []
    
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
        self.rightButton.setTitle("Generate", for: .normal)
        self.textInputbar.autoHideRightButton = false
        
        self.textInputbar.counterStyle = .split
        self.textInputbar.counterPosition = .top
        self.isInverted = true
        
        self.textView.maxNumberOfLines = 6
    }

    func configDataSource () {
        
    }
    
}

extension ViewController {
    override func didPressRightButton(_ sender: Any?) {
        self.textView.refreshFirstResponder()
        
        let text = self.textView.text
        if let result = text?.toTweets(50)?.map({ Tweet(text: $0) }) {
            self.allTweets.insert(contentsOf: result, at: 0)
            self.tableView.reloadData()
        }
        
//        let indexPath = IndexPath(row: 0, section: 0)
//        let rowAnimation: UITableViewRowAnimation = self.isInverted ? .bottom : .top
//        let scrollPosition: UITableViewScrollPosition = self.isInverted ? .bottom : .top
//
//        self.tableView.beginUpdates()
//        self.allTweets.insert(tweet, at: 0)
//        self.tableView.insertRows(at: [indexPath], with: rowAnimation)
//        self.tableView.endUpdates()
//
//        self.tableView.scrollToRow(at: indexPath, at: scrollPosition, animated: true)
//        self.tableView.reloadRows(at: [indexPath], with: .automatic)
        
        super.didPressRightButton(sender)
    }
}

extension ViewController {
    
    // MARK: - UITableViewDataSource Methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.allTweets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return self.tweetCellAt(indexPath)
    }
    
    func tweetCellAt(_ indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "CellID") else {
            let cell =  UITableViewCell(style: .default, reuseIdentifier: "CellID")
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.lineBreakMode = .byWordWrapping
            return cell
        }
        cell.transform = self.tableView.transform
        
        let tweet = self.allTweets[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = tweet.text
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
}

