//
//  UIViewCollectionCell_Home_FanCount.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 2..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UIViewCollectionCell_Home_FanCount : UICollectionViewCell
{
    @IBOutlet var Rank: UIImageView!
    @IBOutlet var Thumbnail: UIImageView!
    @IBOutlet var FanCount: UILabel!
    
    public func SetHomeFanCountData(userIndex : Int, rank : Int)
    {
        CommonUIFunc.Instance.SetDefaultThumbnail(imageView : Thumbnail, circle : false)
        
        if let cellUserData = DataMgr.Instance.GetCachingUserDataList(index: userIndex)
        {
            CommonUIFunc.Instance.SetThumbnail(imageView :  Thumbnail, url : URL(string: cellUserData.GetMainThumbnail())!, circle : false)

            FanCount.text = CommonUIFunc.Instance.ConvertNumberFormatDouble(count: cellUserData.FanCount, addString : "명")
            
            let rankIcon = CommonUIFunc.Instance.GetMainRankImgName(rank: rank)
            if rankIcon.isEmpty == false
            {
                Rank.image = UIImage.init(named: rankIcon)
            }
        }
    }
}
