//
//  BlockData.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 24..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
class BlockData
{
    var Idx : Int = 0
    var NickName : String = ""
    var Img : String = ""
    
    public init()
    {
        self.Idx = 0
        self.NickName = ""
        self.Img = ""
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
        
        if let tempNickName = tempData["NickName"] as? String {
            NickName = tempNickName
        }
        else
        {
            NickName = ""
        }
        
        if let tempImg = tempData["Img"] as? String {
            Img = tempImg
        }
        else
        {
            Img = ""
        }
        
        
    }
}
