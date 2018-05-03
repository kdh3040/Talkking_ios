//
//  UIViewCollectionCell_Home_New.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 2..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UIViewCollectionCell_Home_New : UICollectionViewCell
{
    @IBOutlet var Thumbnail: UIImageView!
    @IBOutlet var AgeName: UILabel!
    public func SetHomeNewData(userIndex : Int)
    {
        CommonUIFunc.Instance.SetDefaultThumbnail(imageView : Thumbnail, circle : false)
        
        if let cellUserData = DataMgr.Instance.GetCachingUserDataList(index: userIndex)
        {
            CommonUIFunc.Instance.SetThumbnail(imageView :  Thumbnail, url : URL(string: cellUserData.GetMainThumbnail())!, circle : false)
            
            AgeName.text = String.init(format: "(%d세)%s", cellUserData.Age, cellUserData.Name)
        }
    }
}
