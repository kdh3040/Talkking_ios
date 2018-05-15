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
            // TODO : 뽑기
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
            // TODO : 뽑기
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
    
    struct JewelData {
        var Name : String = ""
        var Image : String = ""
        var Percent : Float = 0
        var Have : Int = 0
    }
    
    var JewelDataList : [JewelData] = [JewelData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        InitData()
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
        // TODO 보석 판매 기능 추가
        print(String.init(format:"%d", index))
    }
    
    
    
    public func RefreshUI()
    {
        SetHaveJewel()
        for i in 0..<JewelDataList.count
        {
            JewelNameList[i].text = JewelDataList[i].Name
            
            if JewelDataList[i].Have == 0
            {
                JewelIconList[i].image = UIImage.init(named: JewelDataList[i].Image)?.withRenderingMode(.alwaysTemplate)
                JewelIconList[i].tintColor = CommonUIFunc.Instance.GetDefaultColor()
                JewelPercentList[i].isHidden = false
                JewelPercentList[i].text = String.init(format:"%f.2", JewelDataList[i].Percent)
                
                JewelHaveList[i].text = "미 보유"
            }
            else
            {
                JewelIconList[i].image = UIImage.init(named: JewelDataList[i].Image)
                JewelPercentList[i].isHidden = true
                JewelHaveList[i].text = String.init(format:"%d 개", JewelDataList[i].Have)
            }
        }
    }
    
    func InitData()
    {
        if JewelDataList.count <= 0
        {
            var tempData = JewelData()
            tempData.Name = "오팔"
            tempData.Image = "icon_item_opal"
            tempData.Percent = 50
            tempData.Have = 0
            JewelDataList.append(tempData)
            
            tempData = JewelData()
            tempData.Name = "진주"
            tempData.Image = "icon_item_pearl"
            tempData.Percent = 25
            tempData.Have = 0
            JewelDataList.append(tempData)
            
            tempData = JewelData()
            tempData.Name = "자수정"
            tempData.Image = "icon_item_amethyst"
            tempData.Percent = 13.5
            tempData.Have = 0
            JewelDataList.append(tempData)
            
            tempData = JewelData()
            tempData.Name = "사파이어"
            tempData.Image = "icon_item_sapphire"
            tempData.Percent = 7
            tempData.Have = 0
            JewelDataList.append(tempData)
            
            tempData = JewelData()
            tempData.Name = "에메랄드"
            tempData.Image = "icon_item_emerald"
            tempData.Percent = 3.5
            tempData.Have = 0
            JewelDataList.append(tempData)
            
            tempData = JewelData()
            tempData.Name = "루비"
            tempData.Image = "icon_item_ruby"
            tempData.Percent = 0.85
            tempData.Have = 0
            JewelDataList.append(tempData)
            
            tempData = JewelData()
            tempData.Name = "다이아몬드"
            tempData.Image = "icon_item_diamond"
            tempData.Percent = 0.15
            tempData.Have = 0
            JewelDataList.append(tempData)
        }
    }
    
    func SetHaveJewel()
    {
        for i in 0..<JewelDataList.count
        {
            JewelDataList[i].Have = (DataMgr.Instance.MyData!.Item[i])!
        }
    }
}
