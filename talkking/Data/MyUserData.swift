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
    public var BlockedDataList : [BlockData] = [BlockData]()
    public var RecvHeartList : [RecvHeartData] = [RecvHeartData]()
    public var UID : String? = nil
    
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
    
    public func SetBlockData(_ blockData:BlockData)
    {
        if IsBlockUser(idx : blockData.Idx) == false
        {
            BlockDataList.append(blockData)
        }
    }
    
    public func RemoveBlockList(idx:Int)
    {
        for i in 0..<BlockDataList.count
        {
            if BlockDataList[i].Idx == idx
            {
                BlockDataList.remove(at: i)
                FireBaseFunc.Instance.RemoveBlockDataList(index: BlockDataList[i].Idx)
                return;
            }
        }
    }
    
    public func IsBlockUser(idx:Int) -> Bool
    {
        for data in BlockDataList
        {
            if data.Idx == idx
            {
                return true
            }
        }
        
        return false
    }
    
    public func SetBlockedData(_ blockData:BlockData)
    {
        if IsBlockedUser(idx : blockData.Idx) == false
        {
            BlockedDataList.append(blockData)
        }
    }
    
    public func IsBlockedUser(idx:Int) -> Bool
    {
        for data in BlockedDataList
        {
            if data.Idx == idx
            {
                return true
            }
        }
        
        return false
    }
    
    public func SetRecvHeartData(_ recvHeartData:RecvHeartData)
    {
        for data in RecvHeartList
        {
            if data.RecvDate == recvHeartData.RecvDate
            {
                return;
            }
        }
        
        RecvHeartList.append(recvHeartData)
        
        RecvHeartList.sort { (a, b) -> Bool in
            return a.RecvDate > b.RecvDate
        }
    }
    
    public func RemoveAllRecvHeartData()
    {
        RecvHeartList.removeAll()
    }
}
