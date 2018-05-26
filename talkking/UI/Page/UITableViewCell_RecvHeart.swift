//
//  UITableViewCell_RecvHeart.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 13..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UITableViewCell_RecvHeart : UITableViewCell
{
    @IBOutlet var Thumbnail: UIImageView!
    @IBOutlet var Count: UILabel!
    @IBOutlet var Time: UILabel!
    
    public func SetRecvHeart(_ data : RecvHeartData)
    {
        CommonUIFunc.Instance.SetThumbnail(imageView: Thumbnail, url: URL(string:data.SendUserImg)!, circle: true)
        Count.text = CommonUIFunc.Instance.ConvertNumberFormat(count: data.RecvHeart)
        
        if CommonUIFunc.Instance.IsTodayTime(time:Date(timeIntervalSince1970: data.RecvDate))
        {
            Time.text = CommonUIFunc.Instance.ConvertTimeString(time: data.RecvDate, format:"HH:mm")
        }
        else
        {
            Time.text = CommonUIFunc.Instance.ConvertTimeString(time: data.RecvDate, format:"yy-MM-dd")
        }
    }
    
}
