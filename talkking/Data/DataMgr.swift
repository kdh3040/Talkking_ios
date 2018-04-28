//
//  DataMgr.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 4. 24..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation

class DataMgr {
    public var CachingBoardDataList : [Int : BoardData] = [Int : BoardData]()
    private var CachingUserDataList : [Int : UserData] = [Int : UserData]()

    private var UserIdxList_RecvHeart : [Int : Int] = [Int : Int]()
    private var UserIdxList_FanCount: [Int : Int] = [Int : Int]()
    private var UserIdxList_Near : [Int : Int] = [Int : Int]()
    private var UserIdxList_New : [Int : Int] = [Int : Int]()
    
    public var MyData : MyUserData?
    
    static let Instance = DataMgr()
    private init() {
 
        
        // 초기 데이터 생성
        // 클래스를 생성 하면 초기에 타는 함수

  
        /*
 // 임시
        var tempData = UserData(userindex: 1, name: "임시1", age: 10, sex: SEX_TYPE.MALE, grade: 1, thumbnailList: ["asdfads"],favorList:[2])
        CahingUserDataList[1] = tempData
        tempData = UserData(userindex: 2, name: "임시2", age: 30, sex: SEX_TYPE.FEMALE, grade: 3, thumbnailList: ["우ㄴㅁㅇㄹㅁㄴㄹ"],favorList:[1])
        CahingUserDataList[2] = tempData
 */
    }

    
    public func GetCachingUserDataList(index:Int) -> UserData?
    {
        if let userData = CachingUserDataList[index]
        {
            return userData
        }
        else
        {
            FireBaseFunc.Instance.LoadUserData(index: String(index), Mydata: false)
        }
        
        // 없는 데이터를 불러 올경우 파이어베이스에 쿼리를 날려 실제 유저가 있는지 확인
        // 실제로 유저가 없는 경우 널처리
        
        return nil
    }
    
    public func SetCachingUserDataList(userData:UserData)
    {
        CachingUserDataList[userData.Index] = userData
        // 겹치는 인덱스의 유저가 들어 올때는 데이터만 갱신
        // 유저데이터를 생성 하거나 갱신 할때 무조건 이함수를 통해서 갱신되어야함
        // 캐싱된 유저데이터 리스트를 하나로 관리하게끔
    }
    
    public func GetBoardData(index:Int) -> BoardData?
    {
        if let boardData = CachingBoardDataList[index]
        {
            return boardData
        }
        
        return nil
    }
    
    public func SetBoardData(boardData:BoardData)
    {
          CachingBoardDataList[boardData.BoardIndex] = boardData
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
    
    
}
