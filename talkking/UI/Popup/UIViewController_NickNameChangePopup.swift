//
//  UIViewController_NickNameChangePopup.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 16..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UIViewController_NickNameChangePopup : UIViewController_Popup
{
    @IBAction func ChangeAction(_ sender: Any) {
        if CommonUIFunc.Instance.IsStringEmptyCheck(text: NickName.text)
        {
            CommonUIFunc.Instance.ShowAlertPopup(
                viewController: self,
                title: "닉네임 변경",
                message: "닉네임의 내용이 없습니다.",
                actionTitle_1: "확인")
        }
        else
        {
            CommonFunc.Instance.UseCoin(cost: CommonData.NICKNAME_CHANGE_COST, view: self, callFunc: {
                // TODO 도형 : 닉네임 변경
                self.DismissPopup()
            })
        }
    }
    @IBAction func CancelAction(_ sender: Any) {
        self.DismissPopup()
    }
    @IBOutlet var NickName: UITextView!
    @IBOutlet var Desc: UILabel!
    var placeholderLabel : UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NickName.delegate = self
        placeholderLabel = UILabel()
        placeholderLabel.text = String.init(format:"(%d자 이내)", CommonData.STR_LIMIT_INPUT_NICKNAME)
        placeholderLabel.sizeToFit()
        NickName.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (NickName.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !NickName.text.isEmpty
        
        if (DataMgr.Instance.MyData?.NickCheckCnt)! > 0
        {
            Desc.text = String.init(format:"닉네임 최초 변경은 무료입니다.\n이후에는 %d코인이 소모됩니다.",CommonData.NICKNAME_CHANGE_COST)
        }
        else
        {
            Desc.text = String.init(format:"닉네임 변경 시 %d코인이 소모됩니다.\n현재 코인 : %d",CommonData.NICKNAME_CHANGE_COST, DataMgr.Instance.MyData!.Coin)
        }
    }
}

extension UIViewController_NickNameChangePopup : UITextViewDelegate
{
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        let currentText = textView.text ?? ""
        return CommonUIFunc.Instance.IsInputStringLimit(string: currentText, limit: CommonData.STR_LIMIT_INPUT_NICKNAME)
    }
}
