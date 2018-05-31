//
//  UITableViewCell_Fan.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 4. 26..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
class UITableViewCell_Fan : UITableViewCell
{
    @IBOutlet var Thumbnail: UIImageView!
    @IBOutlet var Rank: UIImageView!
    @IBOutlet var RankLabel: UILabel!
    @IBOutlet var NewIcon: UIImageView!
    @IBOutlet var Name: UILabel!
    @IBOutlet var Grade: UIImageView!
    @IBOutlet var BestItem: UIImageView!
    @IBOutlet var HeartCount: UILabel!
    @IBOutlet var Indicator: UIImageView!
    var Index : Int = 0
    public func SetFanCell(userData:UserData, rank : Int, RecvHeart : Int)
    {
        let realRank = rank + 1
        CommonUIFunc.Instance.SetThumbnail(imageView :  Thumbnail, url : URL(string: userData.GetMainThumbnail())!, circle : true)
        
        CommonUIFunc.Instance.SetUserName(label: Name, userData: userData)
        Grade.image = UIImage.init(named: CommonUIFunc.Instance.GetGradeImgName(grade:userData.Grade))
        
        BestItem.image = UIImage.init(named: CommonUIFunc.Instance.GetItemImgName(bestItem: userData.BestItem))
        
        if realRank <= CommonData.FAN_RANK_ICON.count
        {
            Rank.isHidden = false
            RankLabel.isHidden = true
            
            Rank.image = UIImage.init(named:
                CommonUIFunc.Instance.GetFanRankImgName(rank: realRank))
        }
        else
        {
            Rank.isHidden = true
            RankLabel.isHidden = false
            
            RankLabel.text = String.init(format: "%d위", realRank)
        }
        
        HeartCount.text = CommonUIFunc.Instance.ConvertNumberFormat(count: RecvHeart)
        
        Indicator.layer.cornerRadius = Indicator.frame.size.width / 2
        Indicator.clipsToBounds = true
        Index = userData.Index
        RefreshUI()
    }
    
    public func RefreshUI()
    {
        if let myData = DataMgr.Instance.MyData
        {
            if myData.IsNewFanList(idx: Index)
            {
                NewIcon.isHidden = false
                Indicator.isHidden = true
            }
            else if myData.IsUpdateFanList(idx: Index)
            {
                NewIcon.isHidden = true
                Indicator.isHidden = false
            }
            else
            {
                NewIcon.isHidden = true
                Indicator.isHidden = true
            }
        }
    }
    
    public func RemoveIcon()
    {
        NewIcon.isHidden = true
        Indicator.isHidden = true
    }
}
