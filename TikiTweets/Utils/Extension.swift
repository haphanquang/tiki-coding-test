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

        let estimateTweetsCount = self.getTweetCountWithIndexes(max: maxLength)
        
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
            
            guard let string = currentString, string.length < maxLength else {
                //error while scanning
                return []
            }

            //append until not reach max length (including index)
            if toValidateTweet.trimmingCharacters(in: .whitespacesAndNewlines).count < maxLength {
                toValidateTweet.append(currentString! as String)
            }
            
            //if new string longer than max -> add prev to result
            if toValidateTweet.count > maxLength && preTweet.count > 0{
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
        
        //estimate the length is correct but value is incorrect
        //so just replace the index
        //can be improvement (!)
        
        var newResult = [String]()
        for i in 1...result.count {
            var arr = result[i-1].components(separatedBy: " ")
            arr.remove(at: 0)
            arr.insert("\(i)/\(result.count)", at: 0)
            newResult.append(arr.joined(separator: " "))
        }
        
        return newResult
    }
    
    func getTweetCountWithIndexes(max: Int) -> Int {
        //first estimate
        let selfCount = self.count
        var estimateTweetsCount = selfCount / max + ((selfCount % max > 0) ? 1 : 0)
        
        //one tweet because <= max
        if estimateTweetsCount == 1 {
            return 1
        }
    
        //change the estimated tweets count until the length not change
        var realTweetCount = Int.max
        var tempToTrack: Int = 0 //track prev estimated
        
        repeat {
            
            tempToTrack = estimateTweetsCount
            
            var stringCount = selfCount
            
            for i in 1...estimateTweetsCount {
                //increase for every part
                let indexString = "\(i)/\(estimateTweetsCount) "
                stringCount = stringCount + indexString.count
            }
            
            realTweetCount = stringCount / max + ((stringCount % max > 0) ? 1 : 0)
            
            if realTweetCount > estimateTweetsCount {
                estimateTweetsCount = realTweetCount
            }
            
        } while tempToTrack < realTweetCount


        return estimateTweetsCount
    }
}
