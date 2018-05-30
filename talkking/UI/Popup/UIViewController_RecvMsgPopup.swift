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
    
    var RecvHeart : RecvHeartData? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = RecvHeart
        {
            FromUserLabel.text = String.init(format:"From : %@", data.SendUserNickName)
            HeartCount.text = CommonUIFunc.Instance.ConvertNumberFormat(count: data.RecvHeart)
            if data.RecvMsg.isEmpty
            {
                Msg.isHidden = false
            }
            else
            {
                Msg.text = data.RecvMsg
            }
        }
    }
    
    public func SetRecvHeartData(data : RecvHeartData)
    {
        RecvHeart = data
    }
}
