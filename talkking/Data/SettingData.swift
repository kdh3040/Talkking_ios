//
//  SettingData.swift
//  talkking
//
//  Created by 도호소프트 on 2018. 5. 30..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation


class SettingData
{
    var AlarmMode_Popup : Bool = true
    var AlarmMode_Sound : Bool = true
    var AlarmMode_Vibe : Bool = true
    
    var SearchMode_StartAge : Int = 0
    var SearchMode_EndAge : Int = 0
    var SearchMode_Gender : Int = 0
    
    var RecvMode_Msg : Int = 0
 
    
    public init(){}
    
    public init( tempData : NSDictionary)
    {
    
        if let  tempAlarmMode_Popup = tempData["AlarmMode_Popup"] as? Bool {
            AlarmMode_Popup = tempAlarmMode_Popup
        }
        else
        {
            AlarmMode_Popup = true
        }
        
        if let  tempAlarmMode_Sound = tempData["AlarmMode_Sound"] as? Bool {
            AlarmMode_Sound = tempAlarmMode_Sound
        }
        else
        {
            AlarmMode_Sound = true
        }
        
        if let  tempAlarmMode_Vibe = tempData["AlarmMode_Vibration"] as? Bool {
            AlarmMode_Vibe = tempAlarmMode_Vibe
        }
        else
        {
            AlarmMode_Vibe = true
        }
        
        
        if let  tempSearchMode_Start = tempData["StartAge"] as? Int {
            SearchMode_StartAge = tempSearchMode_Start
        }
        else
        {
            SearchMode_StartAge = 20
        }
        
        if let  tempSearchMode_Start = tempData["EndAge"] as? Int {
            SearchMode_EndAge = tempSearchMode_Start
        }
        else
        {
            SearchMode_EndAge = 40
        }
        
        if let  tempSearchMode_Gender = tempData["SearchMode"] as? Int {
            SearchMode_Gender = tempSearchMode_Gender
        }
        else
        {
            SearchMode_Gender = 0
        }
        
        if let  tempRecvMode_Msg = tempData["RecvMsgReject"] as? Int {
            RecvMode_Msg = tempRecvMode_Msg
        }
        else
        {
            RecvMode_Msg = 0
        }
        
    }
}
