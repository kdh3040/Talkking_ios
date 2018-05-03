//
//  CommonUIFunc.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 4. 25..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

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
    
    public func GetMainRankImgName(rank:Int) -> String{
        if(rank <= 0 || CommonData.MAIN_RANK_ICON.count <= rank)
        {
            return ""
        }
        return CommonData.MAIN_RANK_ICON[rank - 1]
    }
    
    
    
    public func IsTodayTime(time:Date) -> Bool
    {
        let calendar = Calendar.current
        return calendar.isDateInToday(time)
    }
    
    public func GetDefaultColor() -> UIColor
    {
        return UIColor(red: 0.463, green: 0.427, blue: 0.671, alpha: 1)
    }
    
    public func ConvertNumberFormat(count:Int, addString : String = "") -> String
    {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value:count))! + addString
    }
    
    public func ConvertNumberFormatDouble(count:Double, addString : String = "") -> String
    {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value:count))! + addString
    }
    
    public func SetThumbnail(imageView : UIImageView, url : Resource, circle : Bool)
    {
        imageView.kf.setImage(with: url,
                              placeholder: nil,
                              options: [.transition(.fade(1))],
                              progressBlock: nil,
                              completionHandler: nil)
    
        SetDefaultThumbnail(imageView : imageView, circle : circle)
    }
    
    public func SetDefaultThumbnail(imageView : UIImageView, circle : Bool)
    {
        if circle == true
        {
            imageView.backgroundColor = CommonUIFunc.Instance.GetDefaultColor()
            imageView.layer.cornerRadius = imageView.frame.size.width / 2
            imageView.clipsToBounds = true
        }
    }
}
