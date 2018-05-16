//
//  Notification.swift
//  talkking
//
//  Created by 도호소프트 on 2018. 5. 16..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation



class NotificationData
{
    var Body : String = ""
    var Title : String = ""
    var Date : String = ""

    
    public init( tempData : NSDictionary)
    {
        
        if let  tempTitle = tempData["Title"] as? String {
            Title = tempTitle
        }
        else
        {
            Title = ""
        }
        
        if let  tempBody = tempData["Body"] as? String {
            Body = tempBody
        }
        else
        {
            Body = ""
        }
        
        if let  tempDate = tempData["Date"] as? String {
            Date = tempDate
        }
        else
        {
            Date = ""
        }
        
        
    }
}
