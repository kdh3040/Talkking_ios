//
//  BoardData.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 4. 24..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation

class BoardData
{
    var BoardIndex : Int = 0
    var UserIndex : Int = 0
    var BoardText : String = ""
    var WriteTime : Double = 0
    var Report : Bool = false
    
    public init( tempData : NSDictionary)
    {
        
       /*
        for noticeUserIndex in noticeList
        {
            if noticeUserIndex == DataMgr.Instance.MyData?.Index
            {
                Notice = true
                break
            }
        }
        */
        
        if let  tempIdx = tempData["Idx"] as? String {
            UserIndex = Int(tempIdx)!
        }
        else
        {
            UserIndex = 0
        }
        
        if let tempBoardIdx = tempData["BoardIdx"] as? Int {
            BoardIndex = tempBoardIdx
        }
        else
        {
            BoardIndex = 0
        }
        
        if let tempMsg = tempData["Msg"] as? String {
            BoardText = tempMsg
        }
        else
        {
            BoardText = ""
        }
        
        if let tempTime = tempData["Date"] as? Double {
            WriteTime = tempTime
        }
        else
        {
            WriteTime = 0
        }
        
        
    }
    /*
    public init(boardIndex : Int, userIndex : Int, boardText : String, writeTime : Date, noticeList : [Int])
    {
        BoardIndex = boardIndex
        UserIndex = userIndex
        BoardText = boardText
        WriteTime = writeTime
        
        Notice = false
        for noticeUserIndex in noticeList
        {
            if noticeUserIndex == DataMgr.Instance.MyData?.Index
            {
                Notice = true
                break
            }
        }
    }
 */
}
