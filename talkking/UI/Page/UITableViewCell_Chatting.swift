//
//  UITableViewCell_Chatting.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 6. 1..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UITableViewCell_Chatting : UITableViewCell
{
    @IBOutlet var MyMsg: UILabel!
    @IBOutlet var ImageBig: UIImageView!
    public func SetMsg(msg:String)
    {
        if msg == "1"
        {
            ImageBig.isHidden = false
            MyMsg.isHidden = true
        ImageBig.kf.setImage(with: URL(string: "https://firebasestorage.googleapis.com/v0/b/talkking-25dd8.appspot.com/o/images%2F1671%2F0?alt=media&token=462742d2-5183-4fe6-a725-d12e8b9ee331"),
                              placeholder: nil,
                              options: [.transition(.fade(1))],
                              progressBlock: nil,
                              completionHandler: nil)
            
        }
        else
        {
            ImageBig.isHidden = true
            MyMsg.isHidden = false
            MyMsg.text = msg
        }
 
        
        //ImageBig.setsize = CGRect(x: 0, y: 0, width: 300, height: 300)
        
        //MyMsg.text = msg
    }
}
