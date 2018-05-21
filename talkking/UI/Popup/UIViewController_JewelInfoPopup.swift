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
                // TODO 도형 : 아이템 판매하는 파이어베이스 코드 추가
                // TODO 환웅 : 아이템을 판매하고 아이템 페이지 갱신하는 코드 추가
                self.DismissPopup()
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
        self.DismissPopup()
    }
    
    var JewelData : CommonData.JewelData? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let jewelData = JewelData
        {
            ResultImg.image = UIImage.init(named: jewelData.InfoImage)
        }
    }
    
    public func SetJewelInfo(index:Int)
    {
        JewelData = CommonData.JewelDataList[index]
    }
}
