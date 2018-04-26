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
    var WriteTime : Date = Date()
    var Notice : Bool = false
    
    public init(boardIndex : Int, userIndex : Int, boardText : String, writeTime : Date, noticeList : [Int])
    {
        BoardIndex = boardIndex
        UserIndex = userIndex
        BoardText = boardText
        WriteTime = writeTime
        
        Notice = false
        for noticeUserIndex in noticeList
        {
            if noticeUserIndex == DataMgr.Instance.MyData?.UserIndex
            {
                Notice = true
                break
            }
        }
    }
}
