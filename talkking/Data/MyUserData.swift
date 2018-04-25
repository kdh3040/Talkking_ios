//
//  MyUserData.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 4. 24..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation

class MyUserData : UserData
{
    public var CahingChatDataList : [ChatData] = [ChatData]()
    
    public init(userIndex : Int)
    {
        let userData = DataMgr.Instance.GetUserData(index: userIndex)
        super.init(userData: userData!)
    }
}
