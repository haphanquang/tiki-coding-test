//
//  Extension.swift
//  TikiTweets
//
//  Created by Phan Quang Ha on 6/28/18.
//  Copyright © 2018 Phan Quang Ha. All rights reserved.
//

import Foundation

extension String {
    
    func toTweets(_ maxLength: Int) -> [String]{
        let estimateTweetsCount = self.count / maxLength + ((self.count % maxLength > 0) ? 1 : 0)
        
        //1 tweet because <= 50
        if estimateTweetsCount == 1 {
            return [self]
        }
        
        var result: [String] = []
        let scanner = Scanner(string: self)
        
        var currentString: NSString? = nil
        var preTweet: String = ""
        
        //always start with "1/count "
        var toValidateTweet: String = "\(result.count + 1)/\(estimateTweetsCount) "

        while (!scanner.isAtEnd) {
            
            //to meet space character
            scanner.scanUpTo(" ", into: &currentString)
            
            guard let _ = currentString else {
                //error while scanning
                return []
            }

            //append until not reach max length (including index)
            if toValidateTweet.trimmingCharacters(in: .whitespacesAndNewlines).count < maxLength {
                toValidateTweet.append(currentString! as String)
            }
            
            //if new string longer than max -> add prev to result
            if toValidateTweet.count > maxLength && preTweet.count > 0 && preTweet.count <= 50{
                result.append(preTweet.trimmingCharacters(in: .whitespacesAndNewlines))
                
                let indexText = "\(result.count + 1)/\(estimateTweetsCount)"
                toValidateTweet = "\(indexText) \(currentString! as String)"
            }
            
            //white space because scanner skip it
            toValidateTweet.append(" ")
            
            //add to pre
            preTweet = toValidateTweet
        }
        
        if preTweet.trimmingCharacters(in: .whitespacesAndNewlines).count <= 50 {
            result.append(preTweet.trimmingCharacters(in: .whitespacesAndNewlines))
        }
        
        return result
    }
}
