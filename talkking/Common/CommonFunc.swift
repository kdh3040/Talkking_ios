//
//  CommonFunc.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 4. 25..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class CommonFunc{
    static let Instance = CommonFunc()
    
    public func IsCoinEnough(coin:Int, viewController:UIViewController? = nil) -> Bool
    {
        if let myData = DataMgr.Instance.MyData
        {
            if myData.Coin >= coin
            {
                return true
            }
            else
            {
                if let view = viewController
                {
                    let ChargeFunc = {
                        let page = view.storyboard?.instantiateViewController(withIdentifier: "CHARGE_PAGE") as! UIViewController_ChargePage
                        view.present(page, animated: true)
                    }
                    
                    CommonUIFunc.Instance.ShowAlertPopup(
                        viewController: view,
                        title: "코인이 부족합니다.",
                        message: String.init(format:"%d코인이 부족합니다.\n충전 하시겠습니까?", coin - myData.Coin),
                        actionTitle_1: "확인",
                        actionFunc_1: ChargeFunc,
                        actionTitle_2: "취소")
                }
            }
        }
        
        return false
    }
    
    static public func InitJewelData()
    {
        if CommonData.JewelDataList.count <= 0
        {
            var tempData = CommonData.JewelData()
            tempData.Name = "오팔"
            tempData.Image = "icon_item_opal"
            tempData.InfoImage = "info_img_opal"
            tempData.Percent = 50
            tempData.Have = 0
            tempData.Index = 0
            CommonData.JewelDataList.append(tempData)
            
            tempData = CommonData.JewelData()
            tempData.Name = "진주"
            tempData.Image = "icon_item_pearl"
            tempData.InfoImage = "info_img_pearl"
            tempData.Percent = 25
            tempData.Have = 0
            tempData.Index = 1
            CommonData.JewelDataList.append(tempData)
            
            tempData = CommonData.JewelData()
            tempData.Name = "자수정"
            tempData.Image = "icon_item_amethyst"
            tempData.InfoImage = "info_img_amethyst"
            tempData.Percent = 13.5
            tempData.Have = 0
            tempData.Index = 2
            CommonData.JewelDataList.append(tempData)
            
            tempData = CommonData.JewelData()
            tempData.Name = "사파이어"
            tempData.Image = "icon_item_sapphire"
            tempData.InfoImage = "info_img_sapphire"
            tempData.Percent = 7
            tempData.Have = 0
            tempData.Index = 3
            CommonData.JewelDataList.append(tempData)
            
            tempData = CommonData.JewelData()
            tempData.Name = "에메랄드"
            tempData.Image = "icon_item_emerald"
            tempData.InfoImage = "info_img_emerald"
            tempData.Percent = 3.5
            tempData.Have = 0
            tempData.Index = 4
            CommonData.JewelDataList.append(tempData)
            
            tempData = CommonData.JewelData()
            tempData.Name = "루비"
            tempData.Image = "icon_item_ruby"
            tempData.InfoImage = "info_img_ruby"
            tempData.Percent = 0.85
            tempData.Have = 0
            tempData.Index = 5
            CommonData.JewelDataList.append(tempData)
            
            tempData = CommonData.JewelData()
            tempData.Name = "다이아몬드"
            tempData.Image = "icon_item_diamond"
            tempData.InfoImage = "info_img_diamond"
            tempData.Percent = 0.15
            tempData.Have = 0
            tempData.Index = 6
            CommonData.JewelDataList.append(tempData)
        }
    }
    
    static public func GetJewelGacha() -> Int
    {
        var returnValue : Int = -1;
        let randomCount = Int(arc4random_uniform(2000))
        
        if 1001 <= randomCount
        {
            returnValue =  0
        }
        else if (501 <= randomCount && randomCount <= 1000)
        {
            returnValue =  1
        }
        else if (231 <= randomCount && randomCount <= 500)
        {
            returnValue =  2
        }
        else if (91 <= randomCount && randomCount <= 230)
        {
            returnValue =  3
        }
        else if (21 <= randomCount && randomCount <= 90)
        {
            returnValue =  4
        }
        else if (4 <= randomCount && randomCount <= 20)
        {
            returnValue =  5
        }
        else if (1 <= randomCount && randomCount <= 3)
        {
            returnValue =  6
        }
        
        return returnValue;
    }
    
    public func UseCoin(cost : Int, view : UIViewController, callFunc : @escaping () -> Void)
    {
        FireBaseFunc.Instance.UpdateMyCoin(complete: {
            if let myData = DataMgr.Instance.MyData
            {
                if CommonFunc.Instance.IsCoinEnough(coin: cost, viewController: view)
                {
                    myData.Coin -= cost
                    FireBaseFunc.Instance.SetMyCoin()
                    
                    callFunc()
                }
            }
        })
    }
    
    public func GetCurrentTime() -> Double
    {
        return round(Date().timeIntervalSince1970 * Double(CommonData.MILLISECOND))
    }
    
    public func IsBoardWriteEnable(showPopup : Bool = true, view :UIViewController? = nil) -> Bool
    {
        if let myData = DataMgr.Instance.MyData
        {
            let wirteEnableTime = myData.BoardWriteTime + Double(CommonData.BOARD_WIRTE_LIMIT_TIME_MIN * CommonData.MILLISECOND)
            if wirteEnableTime > GetCurrentTime()
            {
                if showPopup ,
                    let popupView = view
                {
                    CommonUIFunc.Instance.ShowAlertPopup(
                        viewController: popupView,
                        title: "게시판",
                        message:String.init(format:"작성 가능 시간까지 %@ 남았습니다.", CommonUIFunc.Instance.ConvertTimeString(time: (wirteEnableTime - GetCurrentTime()) / Double(CommonData.MILLISECOND), format: "mm분ss초")),
                        actionTitle_1: "확인")
                }
                return false
            }
        }
        return true
    }
    
    public func CalcDistanceByLonLat(SourceLat : Double, SourceLon : Double, DefLat : Double, DefLon : Double) -> Double
    {
        
        let rMyLat = SourceLat * M_PI / 180
        let rMyLon = SourceLon * M_PI / 180
        
        let rRefLat = DefLat * M_PI / 180
        let rRefLon = DefLon * M_PI / 180
        
        let theta = sin(rMyLat) * sin(rRefLat) +
            cos(rMyLat) * cos(rRefLat) *
            cos(rMyLon - rRefLon)
        
        let CenterTheta = acos(theta)
        
        let radius = CommonData.RADIUS
        
        return radius * CenterTheta
    }
    
    public func ConvertGenderString(gender:GENDER_TYPE) -> String
    {
        if gender == GENDER_TYPE.FEMALE
        {
            return "Woman"
        }
        else
        {
            return "Man"
        }
    }
    
    public func ConvertGenderString(gender:String) -> String
    {
        if gender == "남자"
        {
            return "Man"
        }
        else
        {
            return "Woman"
        }
    }
    
    public func IsMsgPopup() -> Bool
    {
        return DataMgr.Instance.MyData!.CahingSettingDataList[0].AlarmMode_Popup
    }
    public func IsMsgSound() -> Bool
    {
        return DataMgr.Instance.MyData!.CahingSettingDataList[0].AlarmMode_Sound
    }
    public func IsMsgVibe() -> Bool
    {
        return DataMgr.Instance.MyData!.CahingSettingDataList[0].AlarmMode_Vibe
    }
    public func IsMsgReject() -> Bool
    {
        if DataMgr.Instance.MyData!.CahingSettingDataList[0].RecvMode_Msg == 0
        {
            return true
        }
        else
        {
            return false
        }
    }
}
