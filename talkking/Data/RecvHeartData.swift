//
//  RecvHeartData.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 26..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
class RecvHeartData
{
    var RecvHeart : Int = 0
    var RecvDate : Double = 0
    var RecvMsg : String = ""
    var SendUserIdx : Int = 0
    var SendUserImg : String = ""
    var SendUserNickName : String = ""
    
    public init( tempData : NSDictionary)
    {
        if let  tempRecvHeart = tempData["nSendHoney"] as? Int {
            RecvHeart = tempRecvHeart
        }
        else
        {
            RecvHeart = 0
        }
        
        if let  tempRecvDate = tempData["strSendDate"] as? Double {
            RecvDate = tempRecvDate
        }
        else
        {
            RecvDate = 0
        }
        
        if let  tempRecvMsg = tempData["strTargetMsg"] as? String {
            RecvMsg = tempRecvMsg
        }
        else
        {
            RecvMsg = ""
        }
        
        if let  tempSendUserIdx = tempData["strSendName"] as? String {
            SendUserIdx = Int(tempSendUserIdx)!
        }
        else
        {
            SendUserIdx = 0
        }
        
        if let  tempSendUserImg = tempData["strTargetImg"] as? String {
            SendUserImg = tempSendUserImg
        }
        else
        {
            SendUserImg = ""
        }

        if let  tempSendUserNickName = tempData["strTargetNick"] as? String {
            SendUserNickName = tempSendUserNickName
        }
        else
        {
            SendUserNickName = ""
        }
    }
}
