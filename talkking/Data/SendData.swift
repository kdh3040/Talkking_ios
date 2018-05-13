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
    var Idx : String = ""
    var Msg : String = ""
    var WriterIdx : String = ""
    
    
    public init()
    {
        self.Check = 0
        self.Idx = ""
        //self.RecvHeart = 0
    }
    
    public init( tempData : NSDictionary)
    {
        
        
        
    }
}
