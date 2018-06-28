//
//  Extension.swift
//  TikiTweets
//
//  Created by Phan Quang Ha on 6/28/18.
//  Copyright © 2018 Phan Quang Ha. All rights reserved.
//

import Foundation

extension String {
    func toTweets(_ maxLength: Int) -> [String]?{
        
        var result: [String] = []
        let scanner = Scanner(string: self)
        
        var currentString: NSString? = nil
        var preTweet: String = ""
        var toValidateTweet: String = ""
        
        
        
        while (!scanner.isAtEnd) {
            scanner.scanUpTo(" ", into: &currentString)
            if toValidateTweet.count < maxLength {
                preTweet = toValidateTweet
                toValidateTweet.append(currentString! as String)
            }
            
            if toValidateTweet.count > maxLength {
                result.append(preTweet)
                
                toValidateTweet = currentString! as String
                preTweet = toValidateTweet
            }
            toValidateTweet.append(" ")
            preTweet = toValidateTweet
        }

        return result
    }
}
