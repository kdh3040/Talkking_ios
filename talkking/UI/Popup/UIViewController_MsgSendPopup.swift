//
//  UIViewController_MsgSendPopup.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 15..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UIViewController_MsgSendPopup : UIViewController_Popup
{
    @IBOutlet var Msg: UITextView!
    @IBOutlet var CoinLabel: UILabel!
 
    var PageUserData : UserData? = nil
    
    @IBAction func SendAction(_ sender: Any) {
        if CommonUIFunc.Instance.IsStringEmptyCheck(text: Msg.text)
        {
            CommonUIFunc.Instance.ShowAlertPopup(
                viewController: self,
                title: "쪽지 보내기",
                message: "메세지의 내용이 없습니다.",
                actionTitle_1: "확인")
        }
        else
        {
            CommonFunc.Instance.UseCoin(cost: CommonData.MSG_COST, view: self, callFunc: {
                FireBaseFunc.Instance.SetChatList(userData : self.PageUserData!, msg : self.Msg.text)
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
    @IBOutlet var Desc: UILabel!
    
    
    var placeholderLabel : UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Msg.delegate = self
        placeholderLabel = UILabel()
        placeholderLabel.text = String.init(format:"(%d자 이내)", CommonData.STR_LIMIT_SEND_MSG)
        placeholderLabel.sizeToFit()
        Msg.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (Msg.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !Msg.text.isEmpty
        
        CoinLabel.text = CommonUIFunc.Instance.ConvertNumberFormat(count: DataMgr.Instance.MyData!.Coin)
        
        Desc.text = String.init(format:"* 쪽지 전송시 건당 %d코인이 차감됩니다.",CommonData.MSG_COST)
    }
    
    public func SetUserData(userData : UserData)
    {
        PageUserData = userData
    }
}

extension UIViewController_MsgSendPopup : UITextViewDelegate
{
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        let currentText = textView.text ?? ""
        return CommonUIFunc.Instance.IsInputStringLimit(string: currentText, limit: CommonData.STR_LIMIT_SEND_MSG)
    }
}
