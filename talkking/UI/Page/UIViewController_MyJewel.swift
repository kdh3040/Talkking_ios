//
//  UIViewController_MyJewel.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 13..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UIViewController_MyJewel : UIViewController
{
    @IBAction func Back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBOutlet var JewelIconList: [UIImageView]!
    @IBOutlet var JewelPercentList: [UILabel]!
    @IBOutlet var JewelNameList: [UILabel]!
    @IBOutlet var JewelHaveList: [UILabel]!
    
    @IBOutlet var JewelSlot_1: UIView!
    @IBOutlet var JewelSlot_2: UIView!
    @IBOutlet var JewelSlot_3: UIView!
    @IBOutlet var JewelSlot_4: UIView!
    @IBOutlet var JewelSlot_5: UIView!
    @IBOutlet var JewelSlot_6: UIView!
    @IBOutlet var JewelSlot_7: UIView!

    
    @IBAction func GachaAction_1(_ sender: Any) {
        let GachaFunc = {
            // TODO 도형 : 코인 확인 및 차감
            if CommonFunc.Instance.IsCoinEnough(coin: CommonData.GACHA_COST, viewController: self)
            {
                self.BuyItem(count : 1)
            }
        }
        
        CommonUIFunc.Instance.ShowAlertPopup(
            viewController: self,
            title: "보석 1개를 뽑을까요?",
            message: String.init(format:"%d코인이 필요합니다.", CommonData.GACHA_COST),
            actionTitle_1: "네",
            actionFunc_1: GachaFunc,
            actionTitle_2: "취소")
    }
    @IBAction func GachaAction_10(_ sender: Any) {
        let GachaFunc = {
            // TODO 도형 : 코인 확인 및 차감
            let gachaCount : Int = 10
            let bonusGachaCount : Int = 1
            if CommonFunc.Instance.IsCoinEnough(coin: CommonData.GACHA_COST * gachaCount, viewController: self)
            {
                self.BuyItem(count : gachaCount + bonusGachaCount)
            }
        }
        
        CommonUIFunc.Instance.ShowAlertPopup(
            viewController: self,
            title: "보석 10개 + 보너스 1개를 뽑을까요?",
            message: String.init(format:"%d코인이 필요합니다.", CommonData.GACHA_COST * 10),
            actionTitle_1: "네",
            actionFunc_1: GachaFunc,
            actionTitle_2: "취소")
        
    }
    @IBAction func CoinCharge(_ sender: Any) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "CHARGE_PAGE") as! UIViewController_ChargePage
        self.present(page, animated: true)
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        CommonFunc.InitJewelData()
        RefreshUI()
        
        JewelSlot_1.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.JewelSell_1)))
        JewelSlot_2.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.JewelSell_2)))
        JewelSlot_3.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.JewelSell_3)))
        JewelSlot_4.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.JewelSell_4)))
        JewelSlot_5.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.JewelSell_5)))
        JewelSlot_6.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.JewelSell_6)))
        JewelSlot_7.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.JewelSell_7)))

    }

    @objc func JewelSell_1(sender : UITapGestureRecognizer) {
        ShowJewelSell(0)
    }
    @objc func JewelSell_2(sender: UITapGestureRecognizer) {
        ShowJewelSell(1)
    }
    @objc func JewelSell_3(sender: UITapGestureRecognizer) {
        ShowJewelSell(2)
    }
    @objc func JewelSell_4(sender: UITapGestureRecognizer) {
        ShowJewelSell(3)
    }
    @objc func JewelSell_5(sender: UITapGestureRecognizer) {
        ShowJewelSell(4)
    }
    @objc func JewelSell_6(sender: UITapGestureRecognizer) {
        ShowJewelSell(5)
    }
    @objc func JewelSell_7(sender: UITapGestureRecognizer) {
        ShowJewelSell(6)
    }
    
    func ShowJewelSell(_ index:Int)
    {
        let data : CommonData.JewelData = CommonData.JewelDataList[index]
        if data.Have > 0
        {
            let page = self.storyboard?.instantiateViewController(withIdentifier: "JEWEL_INFO_POPUP") as! UIViewController_JewelInfoPopup
            page.SetJewelInfo(index: index)
            page.ShowPopup(viewController: self)
        }
    }
    
    
    
    public func RefreshUI()
    {
        SetHaveJewel()
        let list = CommonData.JewelDataList
        for i in 0..<list.count
        {
            JewelNameList[i].text = list[i].Name
            
            if list[i].Have == 0
            {
                JewelIconList[i].image = UIImage.init(named: list[i].Image)?.withRenderingMode(.alwaysTemplate)
                JewelIconList[i].tintColor = CommonUIFunc.Instance.GetDefaultColor()
                JewelPercentList[i].isHidden = false
                JewelPercentList[i].text = String.init(format:"%.2f", list[i].Percent)
                
                JewelHaveList[i].text = "미 보유"
            }
            else
            {
                JewelIconList[i].image = UIImage.init(named: list[i].Image)
                JewelPercentList[i].isHidden = true
                JewelHaveList[i].text = String.init(format:"%d 개", list[i].Have)
            }
        }
    }
    
    
    
    func SetHaveJewel()
    {
        for i in 0..<CommonData.JewelDataList.count
        {
            CommonData.JewelDataList[i].Have = (DataMgr.Instance.MyData!.Item[i])!
        }
    }
    
    func BuyItem(count:Int)
    {
        for _ in 0..<count
        {
            let page = self.storyboard?.instantiateViewController(withIdentifier: "JEWEL_INFO_POPUP") as! UIViewController_JewelInfoPopup
            page.SetJewelInfo(index: CommonFunc.GetJewelGacha())
            page.ShowPopup(viewController: self)
        }
    }
}
