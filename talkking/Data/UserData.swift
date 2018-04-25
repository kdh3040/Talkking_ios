//
//  UserData.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 4. 24..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation

public enum SEX_TYPE : Int
{
    case MALE = 1
    case FEMALE = 0
}

class UserData
{
    var UserIndex : Int = 0
    var Name : String?
    var Age : Int = 0
    var Sex : SEX_TYPE = SEX_TYPE.MALE
    var Grade : Int = 0
    var ThumbnailList : [String]?
    var FavorUserIndexList : [Int]?
    
    public init(userindex:Int, name:String, age:Int, sex:SEX_TYPE, grade:Int, thumbnailList:[String]
        , favorList:[Int])
    {
        UserIndex = userindex
        Name = name
        Age = age
        Sex = sex
        Grade = grade
        ThumbnailList = thumbnailList
        FavorUserIndexList = favorList
    }
}
