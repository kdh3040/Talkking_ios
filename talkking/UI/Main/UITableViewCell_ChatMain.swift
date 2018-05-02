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
        if let cellUserData = userData
        {
            let url = URL(string: cellUserData.GetMainThumbnail())!
            Thumbnail.kf.setImage(with: url,
                                  placeholder: nil,
                                  options: [.transition(.fade(1))],
                                  progressBlock: nil,
                                  completionHandler: nil)
            
            Thumbnail.layer.cornerRadius = Thumbnail.frame.size.width / 2
            Thumbnail.clipsToBounds = true
            
            Name.text = cellUserData.Name
            Grade.image = UIImage.init(named: CommonUIFunc.Instance.GetGradeImgName(grade:cellUserData.Grade))
            
            BestItem.image = UIImage.init(named: CommonUIFunc.Instance.GetItemImgName(bestItem: cellUserData.BestItem))
        }
    }
}
