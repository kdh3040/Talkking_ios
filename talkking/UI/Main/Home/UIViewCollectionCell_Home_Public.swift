//
//  UIViewCollectionCell_Public.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 2..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UIViewCollectionCell_Home_Public : UICollectionViewCell
{
    @IBOutlet var HeartCount: UILabel!
    @IBOutlet var Thumbnail: UIImageView!
    @IBOutlet var Rank: UIImageView!
    
    public func SetHomePublicData(userIndex : Int, rank : Int)
    {
        CommonUIFunc.Instance.SetDefaultThumbnail(imageView : Thumbnail, circle : false)

        if let cellUserData = DataMgr.Instance.GetCachingUserDataList(index: userIndex)
        {
            CommonUIFunc.Instance.SetThumbnail(imageView :  Thumbnail, url : URL(string: cellUserData.GetMainThumbnail())!, circle : false)

            HeartCount.text = CommonUIFunc.Instance.ConvertNumberFormat(count: cellUserData.RecvHeart)
            
            let rankIcon = CommonUIFunc.Instance.GetMainRankImgName(rank: rank)
            if rankIcon.isEmpty == false
            {
                Rank.image = UIImage.init(named: rankIcon)
            }
        }
    }
}
