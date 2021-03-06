//
//  UITableViewCell_Favor.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 4. 23..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class UITableViewCell_Favor : UITableViewCell
{
    @IBOutlet var Grade: UIImageView!
    @IBOutlet var Name: UILabel!
    @IBOutlet var Thumbnail: UIImageView!
    @IBOutlet var BestItem: UIImageView!
    
    public func SetFavorCell(userData:UserData)
    {
        CommonUIFunc.Instance.SetThumbnail(imageView :  Thumbnail, url : URL(string: userData.GetMainThumbnail())!, circle : true)
        
        CommonUIFunc.Instance.SetUserName(label: Name, userData: userData)
        Grade.image = UIImage.init(named: CommonUIFunc.Instance.GetGradeImgName(grade:userData.Grade))
        
        BestItem.image = UIImage.init(named: CommonUIFunc.Instance.GetItemImgName(bestItem: userData.BestItem))
    }
}
