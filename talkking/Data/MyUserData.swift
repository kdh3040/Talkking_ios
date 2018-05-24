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
    private var ChatDataIdx_List : [Int : Int] = [Int : Int]()
    public var BlockDataList : [BlockData] = [BlockData]()
    
    public init(index : Int)
    {
        let userData = DataMgr.Instance.GetCachingUserDataList(index: index)
        super.init(userData: userData!)
        
        for i in 0..<userData!.ChatDataList.count
        {
            SetChatDataIdxList(ViewIndex: i, userIndex: userData!.ChatDataList[i].Idx)
            CahingChatDataList.append(userData!.ChatDataList[i])
        }
    }
    
    
    public func SetChatDataIdxList(ViewIndex : Int, userIndex : Int)
    {
        ChatDataIdx_List[ViewIndex] = userIndex
    }
    public func GetChatDataIdxList(index:Int) -> Int
    {
        if let userIndex = ChatDataIdx_List[index]
        {
            return userIndex
        }
        
        return 0
    }
    
    public func RemoveBlockList(idx:Int)
    {
        for i in 0..<BlockDataList.count
        {
            if BlockDataList[i].Idx == idx
            {
                BlockDataList.remove(at: i)
                return;
            }
        }
    }
}
