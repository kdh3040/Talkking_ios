//
//  UIViewController_JewelResultPopup.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 17..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UIViewController_JewelInfoPopup : UIViewController_Popup
{
    @IBOutlet var ResultImg: UIImageView!
    @IBAction func SellAction(_ sender: Any) {
        if let jewelData = JewelData
        {
            let itemSell = {
                CommonFunc.Instance.UseCoin(cost: -jewelData.SellCost, view: self, callFunc: {
                        if let myData = DataMgr.Instance.MyData
                        {
                            myData.Item[self.JewelData!.Index] = myData.Item[self.JewelData!.Index]! - 1
                        }
                        if let refreshFunc = self.RefreshFunc
                        {
                            refreshFunc()
                        }
                        FireBaseFunc.Instance.UpdateJewelData()
                        self.DismissPopup()
                    })
            }
            
            CommonUIFunc.Instance.ShowAlertPopup(
                viewController: self,
                title: "아이템 판매", message: String.init(format:"%@ 아이템을 %d코인에 판매합니다.", jewelData.Name, jewelData.SellCost),
                actionTitle_1: "판매",
                actionFunc_1: itemSell,
                actionTitle_2: "취소")
        }
    }
    @IBAction func OkAction(_ sender: Any) {
        
        if let refreshFunc = RefreshFunc
        {
            refreshFunc()
        }
        self.DismissPopup()
    }
    
    var JewelData : CommonData.JewelData? = nil
    var RefreshFunc : (() -> Void)? = nil
    var Gacha : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let jewelData = JewelData
        {
            ResultImg.image = UIImage.init(named: jewelData.InfoImage)
        }
    }
    
    public func SetJewelInfo(index:Int, gacha : Bool, refreshFunc : (() -> Void)? = nil)
    {
        JewelData = CommonData.JewelDataList[index]
        Gacha = gacha
        RefreshFunc = refreshFunc
        
        if let myData = DataMgr.Instance.MyData,
            Gacha
        {
            myData.Item[index] = myData.Item[index]! + 1
            FireBaseFunc.Instance.UpdateJewelData()
        }
    }
}
