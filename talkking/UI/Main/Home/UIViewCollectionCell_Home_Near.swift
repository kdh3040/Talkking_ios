//
//  UIViewCollectionCell_Home_Near.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 2..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UIViewCollectionCell_Home_Near : UICollectionViewCell
{
    @IBOutlet var Thumbnail: UIImageView!
    @IBOutlet var Rank: UIImageView!
    @IBOutlet var Near: UILabel!
    public func SetHomeNearData(userIndex : Int)
    {
        CommonUIFunc.Instance.SetDefaultThumbnail(imageView : Thumbnail, circle : false)
        
        if let cellUserData = DataMgr.Instance.GetCachingUserDataList(index: userIndex)
        {
            CommonUIFunc.Instance.SetThumbnail(imageView :  Thumbnail, url : URL(string: cellUserData.GetMainThumbnail())!, circle : false)
            
            Near.text = CommonUIFunc.Instance.ConvertNumberFormatDouble(count: cellUserData.Distance, addString : "Km")
        }
    }
}
