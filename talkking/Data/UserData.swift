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
    var ImgCount : Int = 0
    var ThumbnailList : [String] = [String]()
    
    var ItemCount : Int = 0
    var BestItem : Int = 0
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
        ImgCount = userData.ImgCount
        ThumbnailList = userData.ThumbnailList
        
        ItemCount = userData.ItemCount
        Item = userData.Item
        
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
        
        if let tempImgCnt = tempData["ImgCount"] as? Int {
            ImgCount =  tempImgCnt
        }
        else
        {
            ImgCount = 1
        }
        
        if let tempThumbImg = tempData["Img"] as? String {
            ThumbnailList.append(tempThumbImg)
        }
        else
        {
            ThumbnailList = ["1"]
        }
        
        
        if let tempImg_0 = tempData["ImgGroup0"] as? String {
            ThumbnailList.append(tempImg_0)
        }
        else
        {
            ThumbnailList.append("1")
        }
        
        if let tempImg_1 = tempData["ImgGroup1"] as? String {
            ThumbnailList.append(tempImg_1)
        }
        else
        {
            ThumbnailList.append("1")
        }
        
        if let tempImg_2 = tempData["ImgGroup2"] as? String {
            ThumbnailList.append(tempImg_2)
        }
        else
        {
            ThumbnailList.append("1")
        }
        
        if let tempImg_3 = tempData["ImgGroup3"] as? String {
            ThumbnailList.append(tempImg_3)
        }
        else
        {
            ThumbnailList.append("1")
        }
        
        if let tempItemCount = tempData["ItemCount"] as? Int {
            ItemCount = tempItemCount
        }
        else
        {
            ItemCount = 0
        }
        
        
        if let tempItem_0 = tempData["Item_1"] as? Int {
            Item[0] = tempItem_0
        }
        else
        {
             Item[0] = 0
        }
        if let tempItem_1 = tempData["Item_2"] as? Int {
            Item[1] = tempItem_1
        }
        else
        {
            Item[1] = 0
        }
        if let tempItem_2 = tempData["Item_3"] as? Int {
            Item[2] = tempItem_2
        }
        else
        {
            Item[2] = 0
        }
        if let tempItem_3 = tempData["Item_4"] as? Int {
            Item[3] = tempItem_3
        }
        else
        {
            Item[3] = 0
        }
        if let tempItem_4 = tempData["Item_5"] as? Int {
            Item[4] = tempItem_4
        }
        else
        {
            Item[4] = 0
        }
        if let tempItem_5 = tempData["Item_6"] as? Int {
            Item[5] = tempItem_5
        }
        else
        {
            Item[5] = 0
        }
        
        if let tempItem_6 = tempData["Item_7"] as? Int {
            Item[6] = tempItem_6
        }
        else
        {
            Item[6] = 0
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
        
        self.SetGrade()
        self.SetBestItem()
    }
   
    public func SetGrade()
    {
        let tempPosition = self.Point / 100
        
        if tempPosition < 2
        {
            self.Grade = 0
        }
        else if 2 <= tempPosition && tempPosition < 3
        {
            self.Grade = 1
        }
        else if 3 <= tempPosition && tempPosition < 5
        {
            self.Grade = 2
        }
        else if 5 <= tempPosition && tempPosition < 10
        {
            self.Grade = 3
        }
        else if 10 <= tempPosition && tempPosition < 20
        {
            self.Grade = 4
        }
        else if 20 <= tempPosition
        {
            self.Grade = 5
        }
    }
    
    public func SetBestItem()
    {
      var tempItem : [Int] = [Int]()
        
        for  ItemValue in Item
        {
           if ItemValue.value != 0
           {
            tempItem.append(ItemValue.key)
            }
        }
        
        tempItem.sorted(by: >)
        self.BestItem = tempItem[0]
        print(tempItem)
        
    }

}
