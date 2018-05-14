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
        if circle == true
        {
            button.layer.cornerRadius = button.frame.size.width / 2
            button.clipsToBounds = true
        }
        
        button.setBackgroundImage(buttonImage.image, for: UIControlState.normal)
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
        if userData.Gender == GENDER_TYPE.FEMALE
        {
            label.textColor = GetFemaleColor()
        }
        else
        {
            label.textColor = GetMaleColor()
        }
    }
    
    public func PushUserPage(userData:UserData, viewController:UIViewController)
    {
        let page = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "USER_PAGE") as! UIViewController_UserPage
        page.SetUserData(userData: userData)
        viewController.present(page, animated: true)
    }
    
    public func IsInputStringLimit(string:String, limit:Int) -> Bool
    {
        // TODO : 한글은 하나가 짤리는데 어떻게 해야 할지 모르겠음
        // 예시
        // 제한이 6이라면
        // 일이삼사오유 <-- 에서 걸림
        // 일이삼사오육 <--- 까지 되야 할것 같은데
        return string.count <= limit
    }
    
    public func OpenThumbnailPic(viewController : UIViewController, thumbnailPicker : UIImagePickerController)
    {
        let alert =  UIAlertController(title: "프로필 사진", message: "선택해주세요", preferredStyle: .actionSheet)
        let library =  UIAlertAction(title: "사진앨범", style: .default) {
            (action) in
            thumbnailPicker.sourceType = .photoLibrary;
            viewController.present(thumbnailPicker, animated: false, completion: nil);
            //(action) in self.openLibrary()
        }
        
        
        let camera =  UIAlertAction(title: "카메라", style: .default) {
            (action) in
                if(UIImagePickerController.isSourceTypeAvailable(.camera)){
                    thumbnailPicker.sourceType = .camera
                    viewController.present(thumbnailPicker, animated: false, completion: nil)
                }
                else{
                    print("Camera not available")
                }
            //(action) in self.openCamera()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(library)
        
        alert.addAction(camera)
        
        alert.addAction(cancel)
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
    public func ShowAlertPopup(viewController : UIViewController, title : String, message : String, actionTitle_1 : String, actionFunc_1 : @escaping () -> Void, actionTitle_2 : String, actionFunc_2 : (() -> Void)? = nil)
    {
        let alertController = UIAlertController(title: title,message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let action_1 = UIAlertAction(title : actionTitle_1 , style:.default){
            (action:UIAlertAction) in actionFunc_1()
        }
        
        let action_2 = UIAlertAction(title : actionTitle_2 , style:.default){
            (action:UIAlertAction) in
            if let actionFunc = actionFunc_2
            {
                actionFunc()
            }
        }
        
        alertController.addAction(action_1)
        alertController.addAction(action_2)
        
        viewController.present(alertController,animated: true,completion: nil)
    }
}
