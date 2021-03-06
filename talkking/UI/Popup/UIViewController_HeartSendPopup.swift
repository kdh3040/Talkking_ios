//
//  UIViewController_HeartSendPopup.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 16..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UIViewController_HeartSendPopup : UIViewController_Popup
{
    @IBOutlet var Coin: UILabel!
    @IBOutlet var Msg: UITextView!
    @IBOutlet var Desc: UILabel!
    var PageUserData : UserData? = nil
    
    @IBAction func SendAction(_ sender: Any) {
        
        if CommonUIFunc.Instance.IsStringEmptyCheck(text: Msg.text)
        {
            CommonUIFunc.Instance.ShowAlertPopup(
                viewController: self,
                title: "하트 보내기",
                message: "메세지의 내용이 없습니다.",
                actionTitle_1: "확인")
        }
        else
        {
            CommonFunc.Instance.UseCoin(cost: self.SelectCost, view: self, callFunc: {
                FireBaseFunc.Instance.SetFavorList(userData: self.PageUserData!)
                FireBaseFunc.Instance.SetFanList(userData: self.PageUserData!, Heart: self.SelectCost, view : self.View!)
                self.DismissPopup()
            })
        }
    }
    @IBAction func CancelAction(_ sender: Any) {
        self.DismissPopup()
    }
    @IBAction func CoinCharge(_ sender: Any) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "CHARGE_PAGE") as! UIViewController_ChargePage
        self.present(page, animated: true)
    }
    @IBOutlet var HeartList: [UIButton]!
    @IBAction func HeartAction_10(_ sender: Any) {
        selectHeartIndex = 0
        RefreshUI()
    }
    @IBAction func HeartAction_30(_ sender: Any) {
        selectHeartIndex = 1
        RefreshUI()
    }
    @IBAction func HeartAction_50(_ sender: Any) {
        selectHeartIndex = 2
        RefreshUI()
    }
    @IBAction func HeartAction_100(_ sender: Any) {
        selectHeartIndex = 3
        RefreshUI()
    }
    @IBAction func HeartAction_300(_ sender: Any) {
        selectHeartIndex = 4
        RefreshUI()
    }
    @IBAction func HeartAction_500(_ sender: Any) {
        selectHeartIndex = 5
        RefreshUI()
    }
    
    var HeartCostList = [10, 30, 50, 100, 300, 500]
    var selectHeartIndex = 0
    var placeholderLabel : UILabel!
    
    var SelectCost = 0
    var View : UIViewController! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Msg.delegate = self
        placeholderLabel = UILabel()
        placeholderLabel.text = String.init(format:"같이 보낼 메세지(%d자 이내)", CommonData.STR_LIMIT_HEART_SEND_MSG)
        placeholderLabel.sizeToFit()
        Msg.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (Msg.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !Msg.text.isEmpty
        
        selectHeartIndex = 0
        RefreshUI()
    }
    
    func RefreshUI()
    {
        Coin.text = CommonUIFunc.Instance.ConvertNumberFormat(count: DataMgr.Instance.MyData!.Coin)
        
        for i in 0..<HeartList.count
        {
            let heartBtn = HeartList[i]
            
            if i == selectHeartIndex
            {
                heartBtn.alpha = 1
            }
            else
            {
                heartBtn.alpha = 0.5
            }
        }
        
        let cost = HeartCostList[selectHeartIndex]
        let myCoin = DataMgr.Instance.MyData!.Coin
        if cost > myCoin
        {
            Desc.text = String.init(format:"코인이 부족합니다. (%d코인 필요)", cost)
        }
        else
        {
            Desc.text = String.init(format:"%d하트를 날리시겟습니까?(%d코인 소모)", cost, cost)
        }
        SelectCost = cost
    }
    
    public func SetUserData(userData : UserData)
    {
        PageUserData = userData
    }
    
    public func SetViewController(view : UIViewController)
    {
        View = view
    }
    
}

extension UIViewController_HeartSendPopup : UITextViewDelegate
{
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        let currentText = textView.text ?? ""
        return CommonUIFunc.Instance.IsInputStringLimit(string: currentText, limit: CommonData.STR_LIMIT_HEART_SEND_MSG)
    }
}
