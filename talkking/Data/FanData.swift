//
//  FanData.swift
//  talkking
//
//  Created by 도호소프트 on 2018. 4. 28..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation

class FanData
{
    var Check : Int = 0
    var Idx : Int = 0
    var RecvHeart : Int = 0
    
    public init()
    {
        self.Check = 0
        self.Idx = 0
        self.RecvHeart = 0
    }
    
    public init( tempData : NSDictionary)
    {
        
        if let  tempIdx = tempData["Idx"] as? String {
            Idx = Int(tempIdx)!
        }
        else
        {
            Idx = 0
        }
        
        if let tempCheck = tempData["Check"] as? Int {
            Check = tempCheck
        }
        else
        {
            Check = 0
        }
        
        if let tempCheck = tempData["RecvGold"] as? Int {
            RecvHeart = tempCheck
        }
        else
        {
            RecvHeart = 0
        }
      
        
    }
}
