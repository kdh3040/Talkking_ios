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
import SVProgressHUD

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
    
    static var StartViewController : UIViewController? = nil
    static var MainTabBarController : UITabBarController_Main? = nil
    static var MainFavorViewController : UIViewController_Favor? = nil
    static var MainViewController : UIViewController_Home? = nil
    static var MainFanViewController : UIViewController_Fan? = nil
    
    public func ShowMainPage()
    {
        let page = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MAIN_PAGE")
        CommonUIFunc.StartViewController!.present(page, animated: true)
    }
    
    public func ShowInputPage(uuid : String, index : String)
    {
        DispatchQueue.main.async {
            let page = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "INPUT_PAGE") as! UIViewController_InputPage
            page.SetMyIndex(uuid : uuid, index : index)
            CommonUIFunc.StartViewController!.present(page, animated: true)
        }
    }
    
    public func RefreshMainTabBar()
    {
        if let view = CommonUIFunc.MainTabBarController
        {
            view.RefreshTabBar()
        }
    }
    
    public func RefreshMainFavor()
    {
        if let view = CommonUIFunc.MainFavorViewController
        {
            view.RefreshUI(true)
        }
    }
    
    public func RefreshMain()
    {
        if let view = CommonUIFunc.MainViewController
        {
            view.RefreshUI()
        }
    }
    
    public func RefreshMainFan()
    {
        if let view = CommonUIFunc.MainFanViewController
        {
            view.RefreshUI()
        }
    }
    
    
    public func GetGradeImgName(grade:Int) -> String{
        if(grade <= 0 || CommonData.RANK_ICON.count <= grade)
        {
            return ""
        }
        return CommonData.RANK_ICON[grade - 1]
    }
    
    public func GetItemImgName(bestItem:Int) -> String{
        if(bestItem < 0 || CommonData.ITEM_ICON.count <= bestItem)
        {
            return ""
        }
        return CommonData.ITEM_ICON[bestItem]
    }
    
    public func GetFanRankImgName(rank:Int) -> String{
        if(rank <= 0 || CommonData.FAN_RANK_ICON.count < rank)
        {
            return ""
        }
        return CommonData.FAN_RANK_ICON[rank - 1]
    }
    
    public func GetFanRankBigImgName(rank:Int) -> String{
        if(rank <= 0 || CommonData.FAN_RANK_ICON_BIG.count < rank)
        {
            return ""
        }
        return CommonData.FAN_RANK_ICON_BIG[rank - 1]
    }
    
    public func GetMainRankImgName(rank:Int) -> String{
        if(rank <= 0 || CommonData.MAIN_RANK_ICON.count <= rank)
        {
            return ""
        }
        return CommonData.MAIN_RANK_ICON[rank - 1]
    }
    
    
    
    public func IsTodayTime(time:Double) -> Bool
    {
        let timeDate = Date(timeIntervalSince1970: time / Double(CommonData.MILLISECOND))
        let calendar = Calendar.current
        return calendar.isDateInToday(timeDate)
    }
    
    public func ConvertTimeString(time:Double, format : String) -> String
    {
        let timeDate = Date(timeIntervalSince1970: time / Double(CommonData.MILLISECOND))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: timeDate)
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
        label.text = String.init(format:"%@(%d세)", userData.Name ,userData.Age)
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
        // TODO 환웅 : 한글은 하나가 짤리는데 어떻게 해야 할지 모르겠음
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
    
    public func ShowAlertPopup(viewController : UIViewController, title : String, message : String, actionTitle_1 : String, actionFunc_1 : (() -> Void)? = nil, actionTitle_2 : String = "", actionFunc_2 : (() -> Void)? = nil)
    {
        let alertController = UIAlertController(title: title,message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let action_1 = UIAlertAction(title : actionTitle_1 , style:.default){
            (action:UIAlertAction) in
            if let actionFunc = actionFunc_1
            {
                actionFunc()
            }
        }
        
        alertController.addAction(action_1)
        
        if actionTitle_2.isEmpty == false
        {
            let action_2 = UIAlertAction(title : actionTitle_2 , style:.default){
                (action:UIAlertAction) in
                if let actionFunc = actionFunc_2
                {
                    actionFunc()
                }
            }
            
            
            alertController.addAction(action_2)
        }

        viewController.present(alertController,animated: true,completion: nil)
    }
    
    
    static public func ShowLoading()
    {
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.clear)
    }
    static public func DismissLoading()
    {
        SVProgressHUD.dismiss()
    }
    
 
    public func IsStringEmptyCheck(text:String) -> Bool
    {
        var tempStr : String = text;
        tempStr = tempStr.replacingOccurrences(of: "\n", with: "")
        tempStr = tempStr.replacingOccurrences(of: " ", with: "")

        return tempStr.count <= 0;
    }
    
    public func MoveUserPage(index:Int, view : UIViewController)
    {
        if let myData = DataMgr.Instance.MyData
        {
            if myData.Index == index
            {
                CommonUIFunc.Instance.ShowAlertPopup(viewController: view, title: "알림", message: "글쓴이가 본인 입니다.", actionTitle_1: "확인")
                return
            }
        }
        if let userData = DataMgr.Instance.GetCachingUserDataList(index: index)
        {
            let page = view.storyboard?.instantiateViewController(withIdentifier: "USER_PAGE") as! UIViewController_UserPage
            page.SetUserData(userData: userData)
            view.present(page, animated: true)
        }
        else
        {
            CommonUIFunc.ShowLoading()
            FireBaseFunc.Instance.LoadUserData(index: String(index), complete: MoveUserPage_LoadUserData, view : view)
        }
    }
    
    private func MoveUserPage_LoadUserData(index : Int, view : UIViewController?)
    {
        CommonUIFunc.DismissLoading()
        let userData : UserData = DataMgr.Instance.GetCachingUserDataList(index: index)!
        let page = view!.storyboard?.instantiateViewController(withIdentifier: "USER_PAGE") as! UIViewController_UserPage
        page.SetUserData(userData: userData)
        view!.present(page, animated: true)
    }
    
    public func IsBlockUser(idx : Int, view : UIViewController, showPopup : Bool = true) -> Bool
    {
        if let myData = DataMgr.Instance.MyData
        {
            if myData.IsBlockUser(idx: idx) == true && showPopup
            {
                self.ShowAlertPopup(viewController: view, title: "차단", message: "당신이 차단한 상대 입니다."
                    , actionTitle_1: "확인")
                return true
            }
            
            if myData.IsBlockedUser(idx: idx) == true && showPopup
            {
                self.ShowAlertPopup(viewController: view, title: "차단", message: "당신은 차단 되었습니다."
                    , actionTitle_1: "확인")
                return true
            }
        }
        
        return false
    }
    
    public func CheckFanRank(userData : UserData, view : UIViewController)
    {
        if userData.FanDataList.count > 0,
            let myData = DataMgr.Instance.MyData
        {
            for i in 0..<userData.FanDataList.count
            {
                if userData.FanDataList[i].Idx == myData.Index && i < CommonData.FAN_RANK_ICON_BIG.count
                {
                    DispatchQueue.main.async {
                        let page = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FAN_RANK_POPUP") as! UIViewController_FanRankPopup
                        page.SetFanRank(rank: i + 1)
                        page.ShowPopup(viewController: view)
                    }
                    break
                }
            }
        }
    }
    
}
