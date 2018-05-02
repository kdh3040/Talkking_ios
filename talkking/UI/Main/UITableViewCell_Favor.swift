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
    
    public func SetFavorCell(userData:UserData?)
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
