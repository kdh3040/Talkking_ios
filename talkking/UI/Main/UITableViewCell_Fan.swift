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
    public func SetFanCell(userData:UserData?, rank : Int)
    {
        // 환웅 인덱스가 0 부터 시작이기 때문
        let realRank = rank + 1
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
            
            if realRank <= 3
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
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            HeartCount.text = numberFormatter.string(from: NSNumber(value:100))
        }
    }
}
