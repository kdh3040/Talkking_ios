//
//  MyUserData.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 4. 24..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation

class MyUserData
{
    public var MyData : UserData?
    
    public init(userIndex:Int) {
        MyData = DataMgr.Instance.GetUserData(index:userIndex)
    }
}
