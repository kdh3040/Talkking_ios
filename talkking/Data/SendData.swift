//
//  SendData.swift
//  talkking
//
//  Created by 도호소프트 on 2018. 5. 13..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation


class SendData
{
    var ChatRoomName : String = ""
    var Check : Int = 0
    var Date : Double = 0
    var Idx : Int = 0
    var Msg : String = ""
    var WriterIdx : String = ""
    
    
    public init()
    {
        self.ChatRoomName = ""
        self.Check = 0
        self.Date = 0
        self.Idx = 0
        self.Msg = ""
        self.WriterIdx = ""

    }
    
    public init( tempData : NSDictionary)
    {
        if let  tempRoomname = tempData["ChatRoomName"] as? String {
            ChatRoomName = tempRoomname
        }
        else
        {
            ChatRoomName = ""
        }
        
        if let tempCheck = tempData["Check"] as? Int {
            Check = tempCheck
        }
        else
        {
            Check = 0
        }
        
        if let tempDate = tempData["Date"] as? Double {
            Date = tempDate
        }
        else
        {
            Date = 0
        }
        if let tempIdx = tempData["Idx"] as? String {
            Idx = Int(tempIdx)!
        }
        else
        {
            Idx = 0
        }
        if let tempMsg = tempData["Msg"] as? String {
            Msg = tempMsg
        }
        else
        {
            Msg = ""
        }
        if let tempWriterIdx = tempData["WriterIdx"] as? String {
            WriterIdx = tempWriterIdx
        }
        else
        {
            WriterIdx = ""
        }
    }
}
