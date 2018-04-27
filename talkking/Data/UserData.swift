//
//  UserData.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 4. 24..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import FirebaseDatabase
public enum SEX_TYPE : String
{
    case MALE = "남자"
    case FEMALE = "여자"
}

class UserData
{
    var Age : Int = 0
    var FavorUserIndexList : [String] = [String]()
    var ConnectDate : Double = 0
    var CreateDate : Double = 0
    var Distance : Double = 0
    var FanCount : Double = 0
    var Sex : SEX_TYPE = SEX_TYPE.MALE
    var Coin : Int = 0
    var Index : Int = 0
    var BoardWriteTime : Double = 0;
    var Lat : Double = 0
    var Lon : Double = 0
    var Memo : String = ""
    var NickCheckCnt : Int = 0
    var Name : String = ""
    var Point : Int = 0
    var RecvHeart : Int = 0
    var Token : String = ""
    
    var Grade : Int = 0
    var ThumbnailList : [String] = [String]()
    var Item : [Int : Int] = [Int: Int]()
    
    
    public init(userData : UserData)
    {
         ConnectDate = userData.ConnectDate
        CreateDate = userData.CreateDate
         Distance = userData.Distance
         FanCount = userData.FanCount
         Coin = userData.Coin
         BoardWriteTime = userData.BoardWriteTime
        
         Lat = userData.Lat
         Lon = userData.Lon
        
         Memo = userData.Memo
         NickCheckCnt = userData.NickCheckCnt
     
         Point = userData.Point
         RecvHeart = userData.RecvHeart
         Token = userData.Token
        
        Age = userData.Age
        Index = userData.Index
        Name = userData.Name
        Sex = userData.Sex
        Grade = userData.Grade
        ThumbnailList = userData.ThumbnailList
        FavorUserIndexList = userData.FavorUserIndexList
    }
 
    /*
     public init(userindex:Int, name:String, age:Int, sex:SEX_TYPE, grade:Int, thumbnailList:[String]
     , favorList:[Int])
     {
     Index = userindex
     Name = name
     Age = age
     Sex = sex
     Grade = grade
     ThumbnailList = thumbnailList
     FavorUserIndexList = favorList
     }
 */
    public init( tempData : NSDictionary)
    {
        if let  tempIdx = tempData["Idx"] as? String {
            Index = Int(tempIdx)!
        }
        else
        {
            Index = 0
        }
        
        if let tempName = tempData["NickName"] as? String {
            Name = tempName
        }
        else
        {
            Name = ""
        }
        
        if let tempAge = tempData["Age"] as? String {
            Age = Int(tempAge)!
        }
        else
        {
            Age = 0
        }
        
        if let tempSex = tempData["Gender"] as? String {
            Sex = SEX_TYPE(rawValue: tempSex)!
        }
        else
        {
            Sex = SEX_TYPE.MALE
        }
        
        if let tempGrade = tempData["Grade"] as? Int {
            Grade = tempGrade
        }
        else
        {
            Grade = 0
        }
        
        if let tempImg = tempData["Img"] as? [String] {
            ThumbnailList = tempImg
        }
        else
        {
            ThumbnailList = ["222"]
        }
        
        if let tempFavor = tempData["CardList"] as? NSDictionary {
            FavorUserIndexList = (tempFavor.allKeys as? [String])!
        }
        else
        {
            FavorUserIndexList = [""]
        }
        
        if let tempConnDate = tempData["ConnectDate"] as? Double {
            ConnectDate = tempConnDate
        }
        else
        {
            ConnectDate = 0
        }
        
        if let tempDate = tempData["Date"] as? Double {
            CreateDate = tempDate
        }
        else
        {
            CreateDate = 0
        }
        
        if let tempDist = tempData["Dist"] as? Double {
            Distance = tempDist
        }
        else
        {
            Distance = 0
        }
        
        if let tempFanCount = tempData["FanCount"] as? Double {
            FanCount = tempFanCount
        }
        else
        {
            FanCount = 0
        }
        
        if let tempCoin = tempData["Honey"] as? Int {
            Coin = tempCoin
        }
        else
        {
            Coin = 0
        }
        
        if let tempBoardWriteDate = tempData["LastBoardWriteTime"] as? Double {
            BoardWriteTime = tempBoardWriteDate
        }
        else
        {
            BoardWriteTime = 0
        }
        
        if let tempLat = tempData["Lat"] as? Double {
            Lat = tempLat
        }
        else
        {
            Lat = 0
        }
        
        if let tempLon = tempData["Lon"] as? Double {
            Lon = tempLon
        }
        else
        {
            Lon = 0
        }
        
        if let tempMemo = tempData["Memo"] as? String {
            Memo = tempMemo
        }
        else
        {
            Memo = ""
        }
        
        if let tempNickChangeCnt = tempData["NickChangeCnt"] as? Int {
            NickCheckCnt = tempNickChangeCnt
        }
        else
        {
            NickCheckCnt = 0
        }
        
        if let tempPoint = tempData["Point"] as? Int {
            Point = tempPoint
        }
        else
        {
            Point = 0
        }
        if let tempRecv = tempData["RecvGold"] as? Int {
            RecvHeart = tempRecv
        }
        else
        {
            RecvHeart = 0
        }
        if let tempToken = tempData["Token"] as? String {
            Token = tempToken
        }
        else
        {
            Token = ""
        }
        
    }
    

}
