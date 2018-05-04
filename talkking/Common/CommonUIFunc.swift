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

struct UserPageAccumulateData {
    public var PageStoryBoardId : String = ""
    public var UserIndex : Int = 0
    
    init(pageStoryBoardId : String, userIndex : Int) {
        PageStoryBoardId = pageStoryBoardId
        UserIndex = userIndex
    }
}

class CommonUIFunc{
    static let Instance = CommonUIFunc()
    
    public var PageAccumulateList : [UserPageAccumulateData] = [UserPageAccumulateData]()
    
    public func EnquePage(storyBoardId : String, userIndex : Int = 0)
    {
        PageAccumulateList.append(UserPageAccumulateData.init(pageStoryBoardId: storyBoardId, userIndex: userIndex))
    }
    
    public func DequePage() -> UserPageAccumulateData?
    {
        if let returnData = PageAccumulateList.popLast()
        {
            return returnData
        }
        
        return nil
    }
    
    
    
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
    
    public func ConvertTimeString(time:Double) -> String
    {
        let timeDate = Date(timeIntervalSince1970: time)
        if CommonUIFunc.Instance.IsTodayTime(time:timeDate)
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            return dateFormatter.string(from: timeDate)
        }
        else
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM월 dd일"
            return dateFormatter.string(from: timeDate)
        }
    }
    
    public func GetDefaultColor() -> UIColor
    {
        return UIColor(red: 0.463, green: 0.427, blue: 0.671, alpha: 1)
    }
    
    public func GetMaleColor() -> UIColor
    {
        return UIColor(red: 0.372, green: 0.725, blue: 0.901, alpha: 1)
    }
    public func GetFemaleColor() -> UIColor
    {
        return UIColor(red: 1, green: 0.686, blue: 1, alpha: 1)
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
    
    public func SetThumbnail(button : UIButton, url : Resource, circle : Bool)
    {
        let buttonImage : UIImageView = UIImageView.init()
        
        buttonImage.kf.setImage(with: url,
                              placeholder: nil,
                              options: [.transition(.fade(1))],
                              progressBlock: nil,
                              completionHandler: nil)
        
        SetDefaultThumbnail(imageView : buttonImage, circle : circle)
        
        button.setImage(buttonImage.image, for: UIControlState.normal)
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
    
    public func SetUserName(label : UILabel, userData : UserData)
    {
        label.text = userData.Name
        if userData.Sex == SEX_TYPE.FEMALE
        {
            label.textColor = GetFemaleColor()
        }
        else
        {
            label.textColor = GetMaleColor()
        }
        
    }
}
