//
//  CommonUIFunc.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 4. 25..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation

class CommonUIFunc{
    static let Instance = CommonUIFunc()
    
    public func GetGradeImgName(grade:Int) -> String{
        if(grade <= 0 || CommonData.RANK_ICON.count <= grade)
        {
            return ""
        }
        return CommonData.RANK_ICON[grade - 1]
    }
    
    public func GetItemImgName(bestItem:Int) -> String{
        if(bestItem <= 0 || CommonData.ITEM_ICON.count <= bestItem)
        {
            return ""
        }
        return CommonData.ITEM_ICON[bestItem - 1]
    }
    
    public func GetFanRankImgName(rank:Int) -> String{
        if(rank <= 0 || CommonData.FAN_RANK_ICON.count <= rank)
        {
            return ""
        }
        return CommonData.FAN_RANK_ICON[rank - 1]
    }
    
    public func IsTodayTime(time:Date) -> Bool
    {
        let calendar = Calendar.current
        return calendar.isDateInToday(time)
    }
}
