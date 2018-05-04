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
    public func SetChatMainCell(userData:UserData?, chatData : ChatData)
    {
        CommonUIFunc.Instance.SetDefaultThumbnail(imageView : Thumbnail, circle : true)
        
        if let cellUserData = userData
        {
            CommonUIFunc.Instance.SetThumbnail(imageView :  Thumbnail, url : URL(string: cellUserData.GetMainThumbnail())!, circle : true)
            
            Name.text = cellUserData.Name
            Grade.image = UIImage.init(named: CommonUIFunc.Instance.GetGradeImgName(grade:cellUserData.Grade))
            
            BestItem.image = UIImage.init(named: CommonUIFunc.Instance.GetItemImgName(bestItem: cellUserData.BestItem))
            
            Time.text = CommonUIFunc.Instance.ConvertTimeString(time: 100)
        }
    }
}
