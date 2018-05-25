//
//  DataMgr.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 4. 24..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation

class DataMgr {
    public var CachingNotificationDataList : [Int : NotificationData] = [Int : NotificationData]()
    public var CachingBoardDataList : [BoardData] = [BoardData]()
    public var CachingMyBoardDataList : [BoardData] = [BoardData]()
    private var CachingUserDataList : [Int : UserData] = [Int : UserData]()
    private var CachingSimpleUserDataList : [Int : UserData] = [Int : UserData]()
    
    private var UserIdxList_RecvHeart : [Int : Int] = [Int : Int]()
    private var UserIdxList_FanCount: [Int : Int] = [Int : Int]()
    private var UserIdxList_Near : [Int : Int] = [Int : Int]()
    private var UserIdxList_New : [Int : Int] = [Int : Int]()
    private var UserIdxList_Hot : [Int : Int] = [Int : Int]()
    
    public var MyData : MyUserData?
    
    static let Instance = DataMgr()
    
    public func GetCachingUserDataList(index:Int) -> UserData?
    {
        if let userData = CachingUserDataList[index]
        {
            return userData
        }
        // 없는 데이터를 불러 올경우 파이어베이스에 쿼리를 날려 실제 유저가 있는지 확인
        // 실제로 유저가 없는 경우 널처리
        
        return nil
    }
    
    public func SetCachingUserDataList(userData:UserData)
    {
        CachingUserDataList[userData.Index] = userData
        
        self.SetCachingSimpleUserDataList(userData:userData)
        // 겹치는 인덱스의 유저가 들어 올때는 데이터만 갱신
        // 유저데이터를 생성 하거나 갱신 할때 무조건 이함수를 통해서 갱신되어야함
        // 캐싱된 유저데이터 리스트를 하나로 관리하게끔
    }
    
    public func GetCachingSimpleUserDataList(index:Int) -> UserData?
    {
        if let userData = CachingSimpleUserDataList[index]
        {
            return userData
        }
        // 없는 데이터를 불러 올경우 파이어베이스에 쿼리를 날려 실제 유저가 있는지 확인
        // 실제로 유저가 없는 경우 널처리
        
        return nil
    }
    
    public func SetCachingSimpleUserDataList(userData:UserData)
    {
        CachingSimpleUserDataList[userData.Index] = userData
        // 겹치는 인덱스의 유저가 들어 올때는 데이터만 갱신
        // 유저데이터를 생성 하거나 갱신 할때 무조건 이함수를 통해서 갱신되어야함
        // 캐싱된 유저데이터 리스트를 하나로 관리하게끔
    }
    
    public func GetBoardData(index:Int) -> BoardData?
    {
        for var data in CachingBoardDataList
        {
            if data.BoardIndex == index
            {
                return data
            }
        }
        
        return nil
    }
    
    public func SetBoardData(boardData:BoardData)
    {
        if let myData = DataMgr.Instance.MyData
        {
            for i in 0..<boardData.ReportList.count
            {
                if boardData.ReportList[i] == myData.Index
                {
                    return
                }
            }
        }
        
        for i in 0..<CachingBoardDataList.count
        {
            if CachingBoardDataList[i].BoardIndex == boardData.BoardIndex
            {
                return
            }
        }
        CachingBoardDataList.append(boardData)

        CachingBoardDataList.sort { (a, b) -> Bool in
            return a.BoardIndex < b.BoardIndex
        }
    }
    
    public func RemoveBoardData(index:Int)
    {
        for i in 0..<CachingBoardDataList.count
        {
            if CachingBoardDataList[i].BoardIndex == index
            {
                CachingBoardDataList.remove(at: i)
                break
            }
        }
    }
    
    public func GetMyBoardData(index:Int) -> BoardData?
    {
        for data in CachingMyBoardDataList
        {
            if data.BoardIndex == index
            {
                return data
            }
        }
        
        return nil
    }
    
    public func SetMyBoardData(boardData:BoardData)
    {
        for i in 0..<CachingMyBoardDataList.count
        {
            if CachingMyBoardDataList[i].BoardIndex == boardData.BoardIndex
            {
                return
            }
        }
        CachingMyBoardDataList.append(boardData)
        
        CachingMyBoardDataList.sort { (a, b) -> Bool in
            return a.BoardIndex < b.BoardIndex
        }
    }
    
    public func RemoveMyBoardData(index:Int)
    {
        for i in 0..<CachingMyBoardDataList.count
        {
            if CachingMyBoardDataList[i].BoardIndex == index
            {
                CachingMyBoardDataList.remove(at: i)
                break
            }
        }
    }

    public func GetNotificationData(index:Int) -> NotificationData?
    {
        if var NotiData = CachingNotificationDataList[index]
        {
            return NotiData
        }
    
        return nil
    }
    
    public func SetNotificationData(index : Int , notiData:NotificationData)
    {
        CachingNotificationDataList[index] = notiData
        // 겹치는 인덱스의 게시글이 들어 올때는 데이터만 갱신
    }
    
    // RecvHeart 기준으로 들어오는 순서대로 유져 인덱스 적재
    public func SetUserDataList_RecvHeart(ViewIndex : Int, userIndex : Int)
    {
        UserIdxList_RecvHeart[ViewIndex] = userIndex
    }
    public func GetUserDataList_RecvHeart(index:Int) -> Int
    {
        if let userIndex = UserIdxList_RecvHeart[index]
        {
            return userIndex
        }
        
        return 0
    }
    public func GetUserDataList_RecvHeart_Count() -> Int
    {
        return UserIdxList_RecvHeart.count
    }
     // FanCount 기준으로 들어오는 순서대로 유져 인덱스 적재
    public func SetUserDataList_FanCount(ViewIndex : Int, userIndex : Int)
    {
        UserIdxList_FanCount[ViewIndex] = userIndex
    }
    public func GetUserDataList_FanCount(index:Int) -> Int
    {
        if let userIndex = UserIdxList_FanCount[index]
        {
            return userIndex
        }
        
        return 0
    }
    
    public func GetUserDataList_FanCount_Count() -> Int
    {
        return UserIdxList_FanCount.count
    }
    
    // Near 기준으로 들어오는 순서대로 유져 인덱스 적재
    public func SetUserDataList_Near(ViewIndex : Int, userIndex : Int)
    {
        UserIdxList_Near[ViewIndex] = userIndex
    }
    public func GetUserDataList_Near(index:Int) -> Int
    {
        if let userIndex = UserIdxList_Near[index]
        {
            return userIndex
        }
        
        return 0
    }
    
    public func GetUserDataList_Near_Count() -> Int
    {
        return UserIdxList_Near.count
    }
    
    // New 기준으로 들어오는 순서대로 유져 인덱스 적재
    public func SetUserDataList_New(ViewIndex : Int, userIndex : Int)
    {
        UserIdxList_New[ViewIndex] = userIndex
    }
    public func GetUserDataList_New(index:Int) -> Int
    {
        if let userIndex = UserIdxList_New[index]
        {
            return userIndex
        }
        
        return 0
    }
    public func GetUserDataList_New_Count() -> Int
    {
        return UserIdxList_New.count
    }
    
    // Hot 기준으로 들어오는 순서대로 유져 인덱스 적재
    public func SetUserDataList_Hot(ViewIndex : Int, userIndex : Int)
    {
        UserIdxList_Hot[ViewIndex] = userIndex
    }
    public func GetUserDataList_Hot(index:Int) -> Int
    {
        if let userIndex = UserIdxList_Hot[index]
        {
            return userIndex
        }
        
        return 0
    }
    public func GetUserDataList_Hot_Count() -> Int
    {
        return UserIdxList_Hot.count
    }
    
    
    
}
