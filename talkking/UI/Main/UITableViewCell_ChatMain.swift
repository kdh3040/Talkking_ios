//
//  UITableViewCell_ChatMain.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 4. 25..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UITableViewCell_ChatMain : UITableViewCell
{
    @IBOutlet var Thumbnail: UIImageView!
    @IBOutlet var Name: UILabel!
    @IBOutlet var Grade: UIImageView!
    @IBOutlet var BestItem: UIImageView!
    @IBOutlet var Chat: UILabel!
    @IBOutlet var Time: UILabel!
    public func SetChatMainCell(userData:UserData, chatData : ChatData)
    {
        CommonUIFunc.Instance.SetThumbnail(imageView :  Thumbnail, url : URL(string: userData.GetMainThumbnail())!, circle : true)
        
        CommonUIFunc.Instance.SetUserName(label: Name, userData: userData)
        Grade.image = UIImage.init(named: CommonUIFunc.Instance.GetGradeImgName(grade:userData.Grade))
        BestItem.image = UIImage.init(named: CommonUIFunc.Instance.GetItemImgName(bestItem: userData.BestItem))
        Time.text = CommonUIFunc.Instance.ConvertTimeString(time: 100, format:"HH")
    }
}
