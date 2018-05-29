//
//  UIViewController_RecvMsgPopup.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 26..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UIViewController_RecvMsgPopup : UIViewController_Popup
{
    @IBOutlet var FromUserLabel: UILabel!
    @IBOutlet var HeartCount: UILabel!
    @IBOutlet var Msg: UITextView!
    @IBAction func OkAction(_ sender: Any) {
        self.DismissPopup()
    }
    @IBAction func DelAction(_ sender: Any) {

        let MsgDelete = {
            FireBaseFunc.Instance.RemoveRecvHeartData()
            if let view = self.RecvHeartListView
            {
                view.RefreshUI()
            }
            self.DismissPopup()
        }
        
        CommonUIFunc.Instance.ShowAlertPopup(
            viewController: self,
            title: "메세지 삭제",
            message: "메세지를 삭제 하시겠습니까?",
            actionTitle_1: "삭제",
            actionFunc_1: MsgDelete,
            actionTitle_2: "취소")
        
        
        
        
    }
    
    var RecvHeart : RecvHeartData? = nil
    var RecvHeartListView : UIViewController_RecvHeartPage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = RecvHeart
        {
            FromUserLabel.text = String.init(format:"From : %@", data.SendUserNickName)
            HeartCount.text = CommonUIFunc.Instance.ConvertNumberFormat(count: data.RecvHeart)
            Msg.text = data.RecvMsg
        }
    }
    
    public func SetRecvHeartData(data : RecvHeartData)
    {
        RecvHeart = data
    }
    
    public func SetRecvHeartListView(view : UIViewController_RecvHeartPage)
    {
        RecvHeartListView = view
    }
}
